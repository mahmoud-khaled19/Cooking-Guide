import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/utils/global_methods.dart';
import 'package:food_app/view/components/meal_item_shape.dart';
import 'package:food_app/view/components/meal_details.dart';
import 'package:food_app/view_model/app_cubit/app_cubit.dart';
import '../view_model/app_cubit/app_state.dart';

class CategoryAndAreaFilterDetailsScreen extends StatelessWidget {
  const CategoryAndAreaFilterDetailsScreen({Key? key, required this.title}) : super(key: key);
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),

      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          AppCubit cubit = BlocProvider.of(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      physics: const BouncingScrollPhysics(),
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 10,
                      children: List.generate(
                        cubit.mealFilter?.meals!.length ?? 2,
                        (index) {
                          var data = cubit.mealFilter!.meals![index];
                          return GestureDetector(
                            onTap: () {
                              cubit.getMealDetails(data.mealId!).then((value) {
                                GlobalMethods.navigateTo(
                                    context, const MealDetails());
                              });
                            },
                            child: FavouriteItem(
                              image: data.mealImage!,
                              name: data.mealName!,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

      ),
    );
  }
}
