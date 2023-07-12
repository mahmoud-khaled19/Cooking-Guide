import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/utils/global_methods.dart';
import 'package:food_app/utils/values_manager.dart';
import 'package:food_app/view/random_meal_screen.dart';
import 'package:food_app/widgets/default_custom_text.dart';
import '../utils/fonts_manager.dart';
import '../view_model/app_cubit.dart';
import '../view_model/app_state.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.currentPage.toString()),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            onTap: (index) {
              cubit.changeScreen(index);
            },
            items: const [
              Icon(Icons.home, size: 30),
              Icon(Icons.search, size: 30),
              Icon(Icons.favorite, size: 30),
              Icon(Icons.person, size: 30),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                DefaultCustomText(
                  text: 'Hello,Koota',
                  fontWeight: FontWeightManager.regular,
                  color: Colors.grey[600],
                ),
                Row(
                  children: [
                    DefaultCustomText(
                      text: 'What Would you Like ',
                      fontSize: AppSize.s20,
                    ),
                    const Spacer(),
                    const CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.red,
                      child: Icon(Icons.person),
                    )
                  ],
                ),
                DefaultCustomText(
                  text: 'to cook today?',
                  fontSize: AppSize.s20,
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
                Container(
                  height: AppSize.s40,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                cubit
                                    .getMealsCategoryFilter(cubit.categoryModel!
                                        .meals![index].categoryName!)
                                    .then((value) {
                                  GlobalMethods.navigateTo(
                                      context, const DetailsScreen());
                                });
                              },
                              child: Container(
                                width: AppSize.s100,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).splashColor,
                                    borderRadius: BorderRadius.circular(12)),
                                margin: const EdgeInsets.only(right: 10),
                                child: DefaultCustomText(
                                  alignment: Alignment.center,
                                  text: cubit.categoryModel!.meals![index]
                                      .categoryName!,
                                  color: Colors.white,
                                  fontSize: AppSize.s12,
                                ),
                              ),
                            );
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
                Container(
                  height: AppSize.s40,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                cubit
                                    .getMealsAreaFilter(cubit
                                        .areaModel!.meals![index].areaName!)
                                    .then((value) {
                                      GlobalMethods.navigateTo(context, const DetailsScreen());
                                });
                              },
                              child: Container(
                                width: AppSize.s100,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).splashColor,
                                    borderRadius: BorderRadius.circular(12)),
                                margin: const EdgeInsets.only(right: 10),
                                child: DefaultCustomText(
                                  alignment: Alignment.center,
                                  text:
                                      cubit.areaModel!.meals![index].areaName!,
                                  color: Colors.white,
                                  fontSize: AppSize.s12,
                                ),
                              ),
                            );
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
                      text: 'choose for you ?',
                      fontSize: AppSize.s16,
                    ),
                    InkWell(
                      onTap: () {
                        GlobalMethods.navigateTo(context, const RandomMeal());
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
          ),
        );
      },
    );
  }
}
