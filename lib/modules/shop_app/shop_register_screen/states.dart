// ignore_for_file: camel_case_types, override_on_non_overriding_member, prefer_typing_uninitialized_variables, overridden_fields, annotate_overrides

import 'package:shop_app/models/shop_app/login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterIntialState extends ShopRegisterStates {}

class ShopRegisterLoodingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  final ShopLoginModel? loginModel;

  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterErrorState extends ShopRegisterStates {
  final String error;

  ShopRegisterErrorState(this.error);
}

class shopRegisterChangePasswordVisibilityState extends ShopRegisterStates {}
