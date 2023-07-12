import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/model/area_model.dart';
import 'package:food_app/model/category_and_area_filter_model.dart';
import 'package:food_app/model/category_model.dart';
import 'package:food_app/model/random_meal_model.dart';
import 'package:food_app/utils/api_constance.dart';
import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  AppCubit get(context) => BlocProvider.of(context);
  RandomMealModel? randomMealModel;
  CategoryModel? categoryModel;
  AreaModel? areaModel;
  MealFilter? mealFilter;

  int currentPage = 0;

  void changeScreen(index) {
    currentPage = index;
    emit(BottomNavigationBarScreensChange());
  }

  Future getRandomMeal() async {
    emit(RandomMealLoadingState());
    await Dio().get(ApiConstance.randomMealUrl).then((value) {
      randomMealModel = RandomMealModel.fromJson(value.data);
      emit(RandomMealSuccessState());
    });
  }

  Future getMealsCategory() async {
    emit(CategoryMealLoadingState());
    await Dio().get(ApiConstance.categoryMealUrl).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      emit(CategoryMealSuccessState());
    });
  }

  Future getMealsArea() async {
    emit(AreaMealLoadingState());
    await Dio().get(ApiConstance.areaMealUrl).then((value) {
      areaModel = AreaModel.fromJson(value.data);
      emit(AreaMealSuccessState());
    });
  }

  Future getMealsCategoryFilter(String categoryName) async {
    emit(FilterMealLoadingState());
    await Dio()
        .get(
            'https://www.themealdb.com/api/json/v1/1/filter.php?c=$categoryName')
        .then((value) {
      mealFilter = MealFilter.fromJson(value.data);
      emit(FilterMealSuccessState());
    });
  }

  Future getMealsAreaFilter(String areaName) async {
    emit(FilterMealLoadingState());
    await Dio()
        .get('https://www.themealdb.com/api/json/v1/1/filter.php?a=$areaName')
        .then((value) {
      mealFilter = MealFilter.fromJson(value.data);
      emit(FilterMealSuccessState());
    });
  }
}
