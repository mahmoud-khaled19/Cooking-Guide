import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/view_model/search_view_model/search_state.dart';

import '../../model/category_and_area_filter_model.dart';
import '../../utils/api_constance.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  SearchCubit get(context) => BlocProvider.of(context);
  MealFilter? mealFilter;
  bool removeData = false;

  removeShownData() {
    removeData =! removeData;
    emit(RemoveShownData());
  }

  Future searchMeals(String mealName, context) async {
    emit(LoadingState());
    await Dio().get('${ApiConstance.searchMealUrl}$mealName').then((value) {
      mealFilter = MealFilter.fromJson(value.data);
      print(mealFilter!.meals);
      emit(SuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorState());
    });
  }
}
