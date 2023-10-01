// ignore_for_file: camel_case_types, override_on_non_overriding_member, prefer_typing_uninitialized_variables, overridden_fields, annotate_overrides

import 'package:shop_app/models/shop_app/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginIntialState extends ShopLoginStates {}

class ShopLoginLoodingState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  final ShopLoginModel? loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginStates {
  final String error;

  ShopLoginErrorState(this.error);
}

class shopChangePasswordVisibilityState extends ShopLoginStates {}
