// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, avoid_print, avoid_function_literals_in_foreach_calls

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/models/shop_app/favoritesmodel/favoritesmodel.dart';
import 'package:shop_app/models/shop_app/home_data_bean/home_data_model.dart';
import 'package:shop_app/modules/shop_app/categories/categories.dart';
import 'package:shop_app/modules/shop_app/favorites/favorites.dart';
import 'package:shop_app/modules/shop_app/products/products.dart';
import 'package:shop_app/shared/network/endpoints.dart';
import 'package:shop_app/shared/network/remote/di0_helper.dart';

import '../../../models/shop_app/favoritesmodel/change_favorite.dart';
import '../../../models/shop_app/categories/categories.dart';
import '../../../models/shop_app/profilemodel/profilemodel.dart';
import '../../../modules/shop_app/settings/settings.dart';
import '../../../shared/components/conestants.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> bottomScreen = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SittengsScreen()
  ];
  void changebottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeDataModel? homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeDataModel.fromJson(value.data);
      printFallText(homeModel!.data!.banners![0].image!);
      print(homeModel?.status);
      homeModel!.data!.products!.forEach(
        (element) {
          favorites.addAll({element.id!: element.inFavorites!});
        },
      );
      print(favorites.toString());
      print(token);
      emit(ShopSuccesHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CatigoriesModel? categoriesModel;
  void getCategoriesData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CatigoriesModel.fromJson(value.data);

      emit(ShopSuccesCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromjson(value.data);
      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavoritesData();
      }

      emit(ShopSuccesChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;

      emit(ShopErrorChangeFavoritesState());
    });
  }

  Favoritesmodel? favoritesModel;
  void getFavoritesData() {
    emit(ShopLoadingGetfavoritesState());
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = Favoritesmodel.fromJson(value.data);
      printFallText(value.data.toString());

      emit(ShopSuccesGetfavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetfavoritesState());
    });
  }

  Profilemodel? userModel;
  void getUserData() {
    emit(ShopLoadingUserDataState());
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = Profilemodel.fromJson(value.data);
      // printFallText(value.data.toString());

      emit(ShopSuccesUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());
    emit(ShopLoadingHomeDataState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = Profilemodel.fromJson(value.data);
      // printFallText(value.data.toString());

      emit(ShopSuccesUpdateUserState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }
}
