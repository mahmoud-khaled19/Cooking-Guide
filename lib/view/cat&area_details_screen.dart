import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/utils/global_methods.dart';
import 'package:food_app/view/components/item.dart';
import 'package:food_app/view/meal_details.dart';
import 'package:food_app/view_model/app_cubit.dart';
import '../view_model/app_state.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.title,this.image}) : super(key: key);
  final String? title;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(title!),
          ),
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
                                  context, const MealDetailsScreen());
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

    );
  }
}
