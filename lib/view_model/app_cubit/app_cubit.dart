import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/model/area_model.dart';
import 'package:food_app/model/category_and_area_filter_model.dart';
import 'package:food_app/model/category_model.dart';
import 'package:food_app/model/random_meal_model.dart';
import 'package:food_app/utils/api_constance.dart';
import 'package:food_app/view/main_screens/home_screen.dart';
import 'package:food_app/view/main_screens/search_screen.dart';
import 'package:food_app/view/main_screens/userInfo_screen.dart';
import '../../utils/global_methods.dart';
import '../../view/main_screens/cat&area_details_screen.dart';
import '../../view/main_screens/favourites_screen.dart';
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

  void changeScreen(index) {
    currentPage = index;
    appScreenBody();
    emit(BottomNavigationBarScreensChange());
  }

  Stream<bool> streamItemInFavorites(String? mealName) {
    if (mealName == null) {
      return Stream.value(false); // Emit a default value if mealName is null.
    }

    return favouritesCollection
        .where('mealName', isEqualTo: mealName)
        .snapshots()
        .map((snapshot) => snapshot.size > 0);
  }

  bool isDark = false;

  changeAppLightModeState() {
    if(isDark ==false){
      return ;
    }
    else{
      isDark = !isDark;
      emit(ChangeAppModeState());
      print('mode is $isDark');
    }
  }
  changeAppDarkModeState() {
    if(isDark ==true){
      return ;
    }
    else{
      isDark = !isDark;
      emit(ChangeAppModeState());
      print('mode is $isDark');
    }

  }

  appScreenBody() {
    if (currentPage == 0) {
      return HomeScreen();
    } else if (currentPage == 1) {
      return SearchScreen();
    } else if (currentPage == 2) {
      return const FavouritesScreen();
    } else if (currentPage == 3) {
      return UserInfoScreen();
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
      print(value);
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
      GlobalMethods.navigateTo(
          context, CategoryAndAreaFilterDetailsScreen(title: categoryName));
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
      GlobalMethods.navigateTo(
          context, CategoryAndAreaFilterDetailsScreen(title: areaName));
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
    required List quantity,
  }) async {
    await favouritesCollection.doc(mealName).set({
      'userId': auth.currentUser!.uid,
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


  void changeFavouriteIcon() {}

  Future deleteFavourite(String mealName, context) async {
    try {
      await favouritesCollection.doc(mealName).delete();
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
