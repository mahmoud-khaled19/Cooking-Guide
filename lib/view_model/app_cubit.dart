import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/model/random_meal_model.dart';
import 'package:food_app/utils/api_constance.dart';
import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  AppCubit get(context) => BlocProvider.of(context);
  RandomMealModel? randomMealModel;

  Future getRandomMeal() async {
    emit(RandomMealLoadingState());
    await Dio().get(ApiConstance.randomMealUrl).then((value) {
      randomMealModel = RandomMealModel.fromJson(value.data);
      emit(RandomMealSuccessState());
    });
  }
}
