// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';

import '../../modules/shop_app/shop_login/shop_loginScreen.dart';

void singout(context) {
  CasheHelper.removeData(key: 'token').then((value) {
    if (value) {
      NavigateAndFinsh(context, ShopLoginScreen());
    }
  });
}

void printFallText(String text) {
  final Pattern = RegExp('.{1,800}'); //800 is the size of each chunk
  Pattern.allMatches(text).forEach(
    (match) => print(
      match.group(0),
    ),
  );
}

String token = '';
String uid = '';
