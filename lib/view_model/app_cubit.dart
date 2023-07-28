import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/model/area_model.dart';
import 'package:food_app/model/category_and_area_filter_model.dart';
import 'package:food_app/model/category_model.dart';
import 'package:food_app/model/random_meal_model.dart';
import 'package:food_app/utils/api_constance.dart';
import 'package:food_app/view/search_screen.dart';
import '../utils/global_methods.dart';
import '../view/cat&area_details_screen.dart';
import '../view/favourites_screen.dart';
import '../view/layout_screen.dart';
import '../view/settings_screen.dart';
import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  AppCubit get(context) => BlocProvider.of(context);
  DetailsMealModel? detailsMealModel;
  CategoryModel? categoryModel;
  AreaModel? areaModel;
  MealFilter? mealFilter;
  int currentPage = 0;


  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore authStore = FirebaseFirestore.instance;
  void changeScreen(index) {
    currentPage = index;
    appScreenBody();
    emit(BottomNavigationBarScreensChange());
  }

  appScreenBody() {
    if (currentPage == 0) {
      return const SearchScreen();
    } else if (currentPage == 1) {
      return const LayoutScreen();
    } else if (currentPage == 2) {
      return const FavouritesScreen();
    } else {
      const SettingsScreen();
    }
  }

  Future getRandomMeal() async {
    emit(RandomMealLoadingState());
    await Dio().get(ApiConstance.randomMealUrl).then((value) {
      detailsMealModel = DetailsMealModel.fromJson(value.data);
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

  Future getMealsCategoryFilter(String categoryName,context) async {
    emit(FilterMealLoadingState());
    await Dio()
        .get(
            'https://www.themealdb.com/api/json/v1/1/filter.php?c=$categoryName')
        .then((value) {
      mealFilter = MealFilter.fromJson(value.data);
      GlobalMethods.navigateTo(
          context, DetailsScreen(title: categoryName));
      emit(FilterMealSuccessState());
    });
  }

  Future getMealsAreaFilter(String areaName,context) async {
    emit(FilterMealLoadingState());
    await Dio()
        .get('${ApiConstance.baseUrl}/1/filter.php?a=$areaName')
        .then((value) {
      mealFilter = MealFilter.fromJson(value.data);
      GlobalMethods.navigateTo(
          context, DetailsScreen(title: areaName));
      emit(FilterMealSuccessState());
    });
  }

  Future getMealDetails(String id) async {
    emit(FilterMealLoadingState());
    await Dio().get('${ApiConstance.baseUrl}/1/lookup.php?i=$id').then((value) {
      detailsMealModel = DetailsMealModel.fromJson(value.data);
      emit(FilterMealSuccessState());
    });
  }
}
