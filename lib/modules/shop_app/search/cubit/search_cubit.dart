import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_app/model/shop_app/search_model.dart';
import 'package:shop_app_app/modules/shop_app/search/cubit/search_state.dart';
import 'package:shop_app_app/shared/componants/constants/constants.dart';
import 'package:shop_app_app/shared/network/end_points.dart';
import 'package:shop_app_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? model;
  void searchData(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(url: SEARCH,taken: taken,
         data: {
      'text': text,

    }).then((value) {
      model = SearchModel.fromJson(value?.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorsState());
      print(error);

    });
  }
}
