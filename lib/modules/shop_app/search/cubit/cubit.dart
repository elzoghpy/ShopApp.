// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/searchmodel/searchmodel.dart';
import 'package:shop_app/modules/shop_app/search/states/states.dart';
import 'package:shop_app/shared/components/conestants.dart';
import 'package:shop_app/shared/network/remote/di0_helper.dart';
import '../../../../shared/network/endpoints.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);
  Searchmodel? model;
  void Search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      model = Searchmodel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
