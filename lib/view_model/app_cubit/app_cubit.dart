import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/model/area_model.dart';
import 'package:food_app/model/category_and_area_filter_model.dart';
import 'package:food_app/model/category_model.dart';
import 'package:food_app/model/random_meal_model.dart';
import 'package:food_app/utils/api_constance.dart';
import 'package:food_app/view/main_screens/search_screen.dart';
import 'package:uuid/uuid.dart';
import '../../utils/global_methods.dart';
import '../../view/cat&area_details_screen.dart';
import '../../view/main_screens/favourites_screen.dart';
import '../../view/main_screens/layout_screen.dart';
import '../../view/main_screens/settings_screen.dart';
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
  final favouritesCollection =
      FirebaseFirestore.instance.collection('favourites');
  IconData favIcon = Icons.favorite_outline_rounded;

  void changeScreen(index) {
    currentPage = index;
    appScreenBody();
    emit(BottomNavigationBarScreensChange());
  }

  Future<bool> checkItemInFavorites(String? mealName) async {
    final item = await favouritesCollection
        .where('mealName', isEqualTo: mealName!)
        .get();
    return item.size > 0;
  }

  appScreenBody() {
    if (currentPage == 0) {
      return SearchScreen();
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

  Future getMealsCategoryFilter(String categoryName, context) async {
    emit(FilterMealLoadingState());
    await Dio()
        .get('${ApiConstance.baseUrl}/filter.php?c=$categoryName')
        .then((value) {
      mealFilter = MealFilter.fromJson(value.data);
      GlobalMethods.navigateTo(context, DetailsScreen(title: categoryName));
      emit(FilterMealSuccessState());
    }).catchError((error) {
      emit(FilterMealErrorState());
    });
  }

  Future getMealsAreaFilter(String areaName, context) async {
    emit(FilterMealLoadingState());
    await Dio()
        .get('${ApiConstance.baseUrl}/filter.php?a=$areaName')
        .then((value) {
      mealFilter = MealFilter.fromJson(value.data);
      GlobalMethods.navigateTo(context, DetailsScreen(title: areaName));
      emit(FilterMealSuccessState());
    }).catchError((error) {
      emit(FilterMealErrorState());
    });
  }

  Future addFavourite({
    context,
    required String image,
    required String mealName,
    required String mealCountry,
    required String source,
    required String videoUrl,
    required String mealInstructions,
    required List items,
    required bool isFavourite,
    required List quantity,
  }) async {
    var mealId = const Uuid().v4();
    await favouritesCollection.doc(mealId).set({
      'userId': auth.currentUser!.uid,
      'isFavourite': isFavourite,
      'mealId': mealId,
      'image': image,
      'mealName': mealName,
      'mealCountry': mealCountry,
      'source': source,
      'videoUrl': videoUrl,
      'mealInstructions': mealInstructions,
      'items': items,
      'quantity': quantity,
    });
  }

  Future deleteFavourite(String mealId, context) async {
    try {
      await favouritesCollection.doc(mealId).delete();
      emit(DeleteFavouriteItem());
    } catch (error) {
      print(error.toString());
    }
  }

  Future getMealDetails(String id) async {
    emit(FilterMealLoadingState());
    await Dio().get('${ApiConstance.baseUrl}/lookup.php?i=$id').then((value) {
      detailsMealModel = DetailsMealModel.fromJson(value.data);
      emit(FilterMealSuccessState());
    }).catchError((error) {
      emit(FilterMealErrorState());
      print(error.toString());
    });
  }
}
