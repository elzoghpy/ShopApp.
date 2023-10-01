import 'package:shop_app/models/shop_app/favoritesmodel/change_favorite.dart';
import 'package:shop_app/models/shop_app/profilemodel/profilemodel.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccesHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccesCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopSuccesChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopSuccesChangeFavoritesState(this.model);
}

class ShopChangeFavoritesState extends ShopStates {}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopLoadingGetfavoritesState extends ShopStates {}

class ShopSuccesGetfavoritesState extends ShopStates {}

class ShopErrorGetfavoritesState extends ShopStates {}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccesUserDataState extends ShopStates {
  final Profilemodel loginModel;

  ShopSuccesUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopStates {}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccesUpdateUserState extends ShopStates {
  final Profilemodel loginModel;

  ShopSuccesUpdateUserState(this.loginModel);
}

class ShopErrorUpdateUserState extends ShopStates {}
