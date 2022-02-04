
import 'package:shop_app_app/model/shop_app/login_model.dart';
import 'package:shop_app_app/model/shop_app/shop_user_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}


class ShopErrorHomeDataState extends ShopStates {}


class ShopSuccessCategoriesDataState extends ShopStates {}

class ShopErrorCategoriesDataState extends ShopStates {}
class ShopSuccessFavoritesDataState extends ShopStates {}

class ShopErrorFavoritesDataState extends ShopStates {}
class ShopLoadingGetFavDataState extends ShopStates {}


class ShopSuccessGetFavoritesDataState extends ShopStates {}

class ShopErrorGetFavoritesDataState extends ShopStates {}

class ShopLoadingUserModelDataState extends ShopStates {}


class ShopSuccessUserModelDataState extends ShopStates {
 final ShopUserModel shopUserModel;

  ShopSuccessUserModelDataState(this.shopUserModel);
}

class ShopErrorUserModelDataState extends ShopStates {}

//
class ShopLoadingUpdateUserModelDataState extends ShopStates {}


class ShopSuccessUpdateUserModelDataState extends ShopStates {
 final ShopUserModel shopUserModel;

  ShopSuccessUpdateUserModelDataState(this.shopUserModel);
}

class ShopErrorUpdateUserModelDataState extends ShopStates {}



