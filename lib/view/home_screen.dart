import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/utils/global_methods.dart';
import 'package:food_app/utils/values_manager.dart';
import 'package:food_app/view/random_meal_screen.dart';
import 'package:food_app/widgets/default_custom_text.dart';
import '../utils/fonts_manager.dart';
import '../view_model/app_cubit.dart';
import '../view_model/app_state.dart';
import 'components/category_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of(context);
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              DefaultCustomText(
                text: 'Hello,Koota',
                fontWeight: FontWeightManager.regular,
                color: Colors.grey[600],
              ),
              DefaultCustomText(
                text: 'What Would you Like ',
                fontSize: AppSize.s16,
              ),
              DefaultCustomText(
                text: 'to cook today?',
                fontSize: AppSize.s16,
              ),
              SizedBox(
                height: AppSize.s20,
              ),
              Row(
                children: [
                  DefaultCustomText(
                    text: 'Categories',
                    fontSize: AppSize.s20,
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    child: DefaultCustomText(
                      text: 'See all',
                      fontSize: AppSize.s12,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: AppSize.s8,
              ),
              SizedBox(
                height: AppSize.s40,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          var data =
                              cubit.categoryModel?.meals![index].categoryName!;
                          return data != null
                              ? CategoryList(
                                  function: () {
                                    cubit.getMealsCategoryFilter(data, context);
                                  },
                                  text: data,
                                  length: cubit.categoryModel!.meals!.length,
                                )
                              : const CircularProgressIndicator();
                        },
                        itemCount: cubit.categoryModel?.meals!.length,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSize.s20,
              ),
              Row(
                children: [
                  DefaultCustomText(
                    text: 'Area',
                    fontSize: AppSize.s20,
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    child: const DefaultCustomText(
                      text: 'See all',
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: AppSize.s8,
              ),
              SizedBox(
                height: AppSize.s40,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          var data = cubit.areaModel?.meals![index].areaName!;
                          return data != null
                              ? CategoryList(
                                  function: () {
                                    cubit.getMealsAreaFilter(data, context);
                                  },
                                  text: data,
                                  length: cubit.areaModel!.meals!.length,
                                )
                              : const CircularProgressIndicator();
                        },
                        itemCount: cubit.areaModel?.meals!.length,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSize.s20,
              ),
              DefaultCustomText(
                text: 'Do you want the app',
                fontSize: AppSize.s16,
              ),
              Row(
                children: [
                  DefaultCustomText(
                    text: 'choose for you?  ',
                    fontSize: AppSize.s16,
                  ),
                  InkWell(
                    onTap: () {
                      cubit.getRandomMeal().then((value) {
                        GlobalMethods.navigateTo(context, const RandomMeal());
                      });
                    },
                    child: DefaultCustomText(
                      text: 'choose',
                      fontSize: AppSize.s12,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
