// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable, unused_import, file_names, avoid_print, import_of_legacy_library_into_null_safe, curly_braces_in_flow_control_structures

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/modules/shop_app/shop_login/cubit.dart';
import 'package:shop_app/modules/shop_app/shop_login/states.dart';
import 'package:shop_app/modules/shop_app/shop_register_screen/shop_register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();
  bool ispassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
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
                            'LOGIN',
                            style:
                                Theme.of(context).textTheme.headline4?.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text('login now to browse our hot offers',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(color: Colors.grey)),
                          SizedBox(
                            height: 30.0,
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
                            onsubmet: (value) {
                              if (formkey.currentState!.validate()) {
                                ShopLoginCubit.get(context).UserLogin(
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text);
                              }
                            },
                            suffix: ShopLoginCubit.get(context).suffix,
                            isPassword: ShopLoginCubit.get(context).ispassword,
                            sufixpressed: () {
                              ShopLoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopLoginLoodingState,
                            builder: (context) => defaultButton(
                              text: 'LOGIN',
                              isUpperCase: true,
                              //   background:   Colors.blueGrey,
                              function: () {
                                if (formkey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).UserLogin(
                                      email: emailcontroller.text,
                                      password: passwordcontroller.text);
                                }
                              },
                            ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an acount?',
                              ),
                              defaultTextButton(
                                  function: (() {
                                    NavigateTo(context, ShopRegisterScreen());
                                  }),
                                  text: 'Regisster')
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
