// ignore_for_file: avoid_print, import_of_legacy_library_into_null_safe, use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/shop_login/shop_loginScreen.dart';
import 'package:shop_app/modules/shop_app/shop_register_screen/states.dart';
import '../../../layout/shop_app/shop_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/cashe_helper.dart';
import '../shop_login/cubit.dart';
import 'cubit.dart';

class ShopRegisterScreen extends StatelessWidget {
  var emailcontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();
  bool ispassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel!.status!) {
              print(state.loginModel?.message);
              print(state.loginModel?.data?.token);
              CasheHelper.saveData(
                      key: 'token', value: state.loginModel?.data?.token)
                  .then((value) {
                NavigateAndFinsh(context, ShopLayout());
              });
            } else {
              print(state.loginModel?.message);
              ShowToast(
                text: state.loginModel!.message!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'REGISTER',
                            style:
                                Theme.of(context).textTheme.headline4?.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text('Register now to browse our hot offers',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(color: Colors.grey)),
                          const SizedBox(
                            height: 30.0,
                          ),
                          defaultFormFaild(
                            controller: namecontroller,
                            type: TextInputType.name,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'this name allready used';
                              }
                              return null;
                            },
                            Label: 'Name',
                            prefix: Icons.person,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultFormFaild(
                            controller: emailcontroller,
                            type: TextInputType.emailAddress,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Email address must be not empty';
                              }
                              return null;
                            },
                            Label: 'Email Adress',
                            prefix: Icons.email_outlined,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultFormFaild(
                            controller: phonecontroller,
                            type: TextInputType.phone,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter your phone number';
                              }
                              return null;
                            },
                            Label: 'Phone',
                            prefix: Icons.phone,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          defaultFormFaild(
                            controller: passwordcontroller,
                            type: TextInputType.visiblePassword,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'password must be not empty';
                              }
                              return null;
                            },
                            Label: 'Password',
                            prefix: Icons.lock,
                            onsubmet: (value) {},
                            suffix: ShopRegisterCubit.get(context).suffix,
                            isPassword:
                                ShopRegisterCubit.get(context).ispassword,
                            sufixpressed: () {
                              ShopRegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopRegisterLoodingState,
                            builder: (context) => defaultButton(
                              text: 'REGISTER',
                              isUpperCase: true,
                              //   background:   Colors.blueGrey,
                              function: () {
                                if (formkey.currentState!.validate()) {
                                  ShopRegisterCubit.get(context).UserRegister(
                                      email: emailcontroller.text,
                                      password: passwordcontroller.text,
                                      name: namecontroller.text,
                                      phone: passwordcontroller.text);
                                }
                              },
                            ),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'If you have an acount?',
                              ),
                              defaultTextButton(
                                  function: (() {
                                    NavigateTo(context, ShopLoginScreen());
                                  }),
                                  text: 'Logine')
                            ],
                          )
                        ]),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
