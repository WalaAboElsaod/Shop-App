import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_app/model/shop_app/categories_model.dart';
import 'package:shop_app_app/model/shop_app/change_favorite_model.dart';
import 'package:shop_app_app/model/shop_app/favorite_model.dart';
import 'package:shop_app_app/model/shop_app/home_model.dart';
import 'package:shop_app_app/model/shop_app/shop_user_model.dart';
import 'package:shop_app_app/modules/shop_app/categories/categories.dart';
import 'package:shop_app_app/modules/shop_app/cubit/states.dart';
import 'package:shop_app_app/modules/shop_app/favorites/favorites.dart';
import 'package:shop_app_app/modules/shop_app/products/products.dart';
import 'package:shop_app_app/modules/shop_app/seetings/seetings.dart';
import 'package:shop_app_app/shared/componants/constants/constants.dart';
import 'package:shop_app_app/shared/network/end_points.dart';
import 'package:shop_app_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  HomeModel? homeModel;

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  late Map<int, bool> favourites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: Home,
      taken: taken,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);


      homeModel?.data?.products.forEach((element) {
        favourites.addAll({
          element.id: element.infavorite,
        });
      });
      print(favourites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      ShopErrorHomeDataState();
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      taken: taken,
    ).then((value) {
      categoriesModel = CategoriesModel.fromjson(value.data);
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error) {
      print(error.toString());
      ShopErrorCategoriesDataState();
    });
  }

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId) {
    favourites[productId] = !favourites[productId]!;
    emit(ShopSuccessFavoritesDataState());

    DioHelper.postData(
        taken: taken,
        url: FAVORITES,
        data: {'product_id': productId}).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print('the  fav is:${changeFavoritesModel?.status}');

      print(DioHelper.dio.options.headers);
      print(DioHelper.dio.options.headers);
      print(value.data);
      if (changeFavoritesModel!.status == false) {
        favourites[productId] = !favourites[productId]!;
        print('wala');
      } else {
        geFavoritesData();
      }
      emit(ShopSuccessFavoritesDataState());
    }).catchError((error) {
      favourites[productId] = !favourites[productId]!;
      print('theeee erro fav is:${error.toString()}');

      ShopErrorFavoritesDataState();
    });
  }

  FavoriteModel? favoriteModel;
  Future geFavoritesData() async {
    emit(ShopLoadingGetFavDataState());

    await DioHelper.getData(
      url: FAVORITES,
      taken: taken,
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      printFullText(value.data.toString());
      emit(ShopSuccessGetFavoritesDataState());
    }).catchError((error) {
      print(':هنا الايرور يا بيه ${error.toString()}');

      emit(ShopErrorGetFavoritesDataState());
    });
  }

  late ShopUserModel shopUserModel;
  Future getUserData() async {
    emit(ShopLoadingUserModelDataState());

    await DioHelper.getData(
      url: PROFILE,
      taken: taken,
    ).then((value) {
      shopUserModel = ShopUserModel.fromJason(value.data);
      print('. :اسم اليوزر${shopUserModel.data?.name}');
      // printFullText(userModel!.data!.name!);
      print('اههههههو الهيدرر  ${DioHelper.dio.options.headers}');
      emit(ShopSuccessUserModelDataState(shopUserModel));
    }).catchError((error) {
      print(':هنا الايرور يا ابلة ${error.toString()}');
      print('اههههههو الهيدرر  ${DioHelper.dio.options.headers}');

      emit(ShopErrorUserModelDataState());
    });
  }

  Future getUpdateUserData({
    required String name,
    required String email,
    required String phone,
  }) async {
    emit(ShopLoadingUpdateUserModelDataState());

    await DioHelper.putData(url: UPDATE_PROFILE, taken: taken, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      shopUserModel = ShopUserModel.fromJason(value.data);
      print(' . :اسمابديا  اليوزر${shopUserModel.data?.name}');
      // printFullText(userModel!.data!.name!);
      print(' الهيدرر  ${DioHelper.dio.options.headers}');
      emit(ShopSuccessUpdateUserModelDataState(shopUserModel));
    }).catchError((error) {
      print(':هنا الايرور يا ابديت ${error.toString()}');
      // print ('اههههههو الهيدرر  ${DioHelper.dio.options.headers}');

      emit(ShopErrorUpdateUserModelDataState());
    });
  }
}
