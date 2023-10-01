// ignore_for_file: depend_on_referenced_packages, unnecessary_null_comparison

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/shop_login/shop_loginScreen.dart';
import 'package:shop_app/shared/cubit_share/cubit.dart';
import 'package:shop_app/shared/cubit_share/states.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';
import 'package:shop_app/shared/network/remote/di0_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'shared/components/conestants.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';

void main() async {
  //ali
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DioHelper.init();
  await CasheHelper.Init();
  bool isDark = CasheHelper.getData(key: 'isDark');
  Widget widget;
  bool onBoarding = CasheHelper.getData(key: 'onBoarding');
  //  token = CasheHelper.getData(key: 'token');
  uid = CasheHelper.getData(key: 'uid');
  // print(token);
  // if (onBoarding != null) {
  //   if (token != null)
  //     widget = ShopLayout();
  //   else
  //     widget = ShopLoginScreen();
  // } else {
  //   widget = OnBoardingScreen();
  // }

  print(onBoarding);
  if (uid != null) {
    widget = ShopLayout();
  } else {
    widget = ShopLoginScreen();
  }
  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final bool isDark;
  final Widget startWidget;
  const MyApp({required this.isDark, required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()
            ..ChangeAppMode(
              formshared: isDark,
            ),
        ),
        BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavoritesData()
              ..getUserData()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}


//             ./gradlew signingReport

