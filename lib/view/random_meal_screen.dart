import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/view_model/app_cubit.dart';
import '../view_model/app_state.dart';
import 'components/meal_item.dart';

class RandomMeal extends StatelessWidget {
  const RandomMeal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getRandomMeal(),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          AppCubit cubit = BlocProvider.of(context);
          return Scaffold(
            appBar: AppBar(
              actions: [
                 Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child:  IconButton(onPressed: () {
                    cubit.getRandomMeal();
                  }, icon: const Icon(Icons.refresh),),
                )
              ],
            ),
            body:  ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                var mealData = cubit.randomMealModel!.meals![index];
               if(mealData.mealContent1!.isNotEmpty || mealData.mealContent11 == null){
                 return MealItem(
                   image: mealData.mealImage,
                   mealName: mealData.mealName,
                   mealCountry: mealData.mealCountry,
                   source: mealData.mealSource,
                   videoUrl: mealData.mealVideo,
                   mealInstructions: mealData.mealInstructions,
                   item1: mealData.mealContent1,
                   item2: mealData.mealContent2,
                   item3: mealData.mealContent3,
                   item4: mealData.mealContent4,
                   item5: mealData.mealContent5,
                   item6: mealData.mealContent6,
                   item7: mealData.mealContent7,
                   item8: mealData.mealContent8,
                   item9: mealData.mealContent9,
                   item10: mealData.mealContent10,
                   item11: mealData.mealContent11,
                   item12: mealData.mealContent12,
                   item13: mealData.mealContent13,
                   item14: mealData.mealContent14,
                   item15: mealData.mealContent15,
                   quantity1: mealData.mealContentQuantity1,
                   quantity2: mealData.mealContentQuantity2,
                   quantity3: mealData.mealContentQuantity3,
                   quantity4: mealData.mealContentQuantity4,
                   quantity5: mealData.mealContentQuantity5,
                   quantity6: mealData.mealContentQuantity6,
                   quantity7: mealData.mealContentQuantity7,
                   quantity8: mealData.mealContentQuantity8,
                   quantity9: mealData.mealContentQuantity9,
                   quantity10: mealData.mealContentQuantity10,
                   quantity11: mealData.mealContentQuantity11,
                   quantity12: mealData.mealContentQuantity12,
                   quantity13: mealData.mealContentQuantity13,
                   quantity14: mealData.mealContentQuantity14,
                   quantity15: mealData.mealContentQuantity15,
                 );
               }
               return Text('2222222222222');
              },
              itemCount: 1,
            )
          );
        },
      ),
    );
  }
}

