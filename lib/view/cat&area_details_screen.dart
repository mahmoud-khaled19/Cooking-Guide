import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/utils/global_methods.dart';
import 'package:food_app/utils/values_manager.dart';
import 'package:food_app/view/meal_details.dart';
import 'package:food_app/view_model/app_cubit.dart';
import 'package:food_app/widgets/default_custom_text.dart';
import '../view_model/app_state.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.title}) : super(key: key);
  final String? title;

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
                          child: detailsMealItem(
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
      },
    );
  }
}

Widget detailsMealItem({
  required String image,
  required String name,
}) {
  return Column(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(imageUrl: image),
      ),
      SizedBox(
        height: AppSize.s10,
      ),
      DefaultCustomText(
        fontSize: AppSize.s12,
        text: name,
        alignment: Alignment.center,
      ),
      SizedBox(
        height: AppSize.s10,
      ),
    ],
  );
}
