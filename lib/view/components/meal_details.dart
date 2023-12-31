import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/view_model/app_cubit/app_cubit.dart';
import '../../view_model/app_cubit/app_state.dart';
import '../main_screens/meal_details_screen.dart';

class MealDetails extends StatelessWidget {
  const MealDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of(context);
        return Scaffold(
            body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            var mealData = cubit.detailsMealModel!.meals![index];
            return MealDetailsScreen(
              image: mealData.mealImage,
              mealName: mealData.mealName,
              mealCountry: mealData.mealCountry,
              source: mealData.mealSource,
              videoUrl: mealData.mealVideo,
              mealInstructions: mealData.mealInstructions,

              items: [
                mealData.mealContent1 ?? '',
                mealData.mealContent2 ?? '',
                mealData.mealContent3 ?? '',
                mealData.mealContent4 ?? '',
                mealData.mealContent5 ?? '',
                mealData.mealContent6 ?? '',
                mealData.mealContent7 ?? '',
                mealData.mealContent8 ?? '',
                mealData.mealContent9 ?? '',
                mealData.mealContent10 ?? '',
                mealData.mealContent11 ?? '',
                mealData.mealContent12 ?? '',
                mealData.mealContent13 ?? '',
                mealData.mealContent14 ?? '',
                mealData.mealContent15 ?? '',
              ],
              quantity: [
                mealData.mealContentQuantity1 ?? '',
                mealData.mealContentQuantity2 ?? '',
                mealData.mealContentQuantity3 ?? '',
                mealData.mealContentQuantity4 ?? '',
                mealData.mealContentQuantity5 ?? '',
                mealData.mealContentQuantity6 ?? '',
                mealData.mealContentQuantity7 ?? '',
                mealData.mealContentQuantity8 ?? '',
                mealData.mealContentQuantity9 ?? '',
                mealData.mealContentQuantity10 ?? '',
                mealData.mealContentQuantity11 ?? '',
                mealData.mealContentQuantity12 ?? '',
                mealData.mealContentQuantity13 ?? '',
                mealData.mealContentQuantity14 ?? '',
                mealData.mealContentQuantity15 ?? '',
              ],
            );
          },
          itemCount: 1,
        ));
      },
    );
  }
}
