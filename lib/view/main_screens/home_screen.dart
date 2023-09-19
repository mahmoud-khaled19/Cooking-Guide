import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/generated/assets.dart';
import 'package:food_app/utils/global_methods.dart';
import 'package:food_app/utils/strings_manager.dart';
import 'package:food_app/utils/values_manager.dart';
import 'package:food_app/view/main_screens/empty_screen.dart';
import 'package:food_app/view/main_screens/random_meal_screen.dart';
import 'package:food_app/widgets/default_custom_text.dart';
import '../../view_model/app_cubit/app_cubit.dart';
import '../../view_model/app_cubit/app_state.dart';
import '../components/category_container.dart';
import '../loading_screen/home_screen_loading_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of(context);
        switch (cubit.areaModel?.meals) {
          case == null || == 0:
        {
        return LoadingHomeScreen();
        }

        case != 0:
        {
        return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
        children: [
        SizedBox(
        height: AppSize.s16,
        ),
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        DefaultCustomText(
        text: 'What Would you Like ',
        fontSize: AppSize.s16,
        ),
        DefaultCustomText(
        text: 'to cook today?',
        fontSize: AppSize.s16,
        ),
        ],
        ),
        ClipRect(
        child: Image(
        image: AssetImage(Assets.imagesChefRafiki),
        height: AppSize.s100,
        width: AppSize.s100,
        ),
        )
        ],
        ),
        SizedBox(
        height: AppSize.s30,
        ),
        DefaultCustomText(
        text: 'Categories',
        fontSize: AppSize.s16,
        ),
        SizedBox(
        height: AppSize.s10,
        ),
        SizedBox(
        height: AppSize.s50,
        child: ListView.builder(
        itemBuilder: (context, index) {
        var data = cubit
            .categoryModel?.meals![index].categoryName!;
        return data != null
        ? CategoryContainer(
        function: () {
        cubit.getMealsCategoryFilter(
        data, context);
        },
        text: data,
        length:
        cubit.categoryModel!.meals!.length,
        )
            : const CircularProgressIndicator();
        },
        itemCount: cubit.categoryModel?.meals!.length,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        ),
        ),
        SizedBox(
        height: AppSize.s16,
        ),
        DefaultCustomText(
        text: 'Area',
        fontSize: AppSize.s16,
        ),
        SizedBox(
        height: AppSize.s10,
        ),
        SizedBox(
        height: AppSize.s50,
        child: ListView.builder(
        itemBuilder: (context, index) {
        var data =
        cubit.areaModel?.meals![index].areaName!;
        return data != null
        ? CategoryContainer(
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
        SizedBox(
        height: AppSize.s50,
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
        GlobalMethods.navigateTo(
        context, const RandomMealScreen());
        });
        },
        child: DefaultCustomText(
        text: 'choose',
        color: Colors.blue,
        ),
        ),
        ],
        ),
        ],
        ),
        );
        }
        }
        return EmptyScreen(
        text: AppStrings.errorMessage, image: Assets.imagesNoPage);
      },
    );
  }
}
