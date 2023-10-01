// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/login_model.dart';
import 'package:shop_app/modules/shop_app/shop_register_screen/states.dart';
import 'package:shop_app/shared/network/remote/di0_helper.dart';

import '../../../shared/network/endpoints.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterIntialState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;
  void UserRegister({
    required String email,
    required String name,
    required String phone,
    required String password,
  }) {
    emit(ShopRegisterLoodingState());
    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    }).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromjson(value.data);
      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool ispassword = true;
  void changePasswordVisibility() {
    ispassword = !ispassword;

    suffix =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(shopRegisterChangePasswordVisibilityState());
  }
}
