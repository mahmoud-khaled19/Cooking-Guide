import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/generated/assets.dart';
import 'package:food_app/utils/global_methods.dart';
import 'package:food_app/utils/values_manager.dart';
import 'package:food_app/view_model/search_view_model/search_cubit.dart';
import 'package:food_app/view_model/search_view_model/search_state.dart';
import 'package:food_app/widgets/default_custom_text.dart';
import 'package:food_app/widgets/elevated_button_widget.dart';
import 'package:food_app/widgets/text_form_field_widget.dart';
import '../../utils/strings_manager.dart';
import '../../view_model/app_cubit/app_cubit.dart';
import '../components/meal_details.dart';
import '../components/meal_item_shape.dart';
import '../empty_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();

    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        SearchCubit cubit = BlocProvider.of(context);
        AppCubit appCubit = BlocProvider.of(context);
        return Form(
          key: formKey1,
          child: Column(
            children: [
              DefaultTextFormField(
                  onSubmittedFunction: () {
                    if (formKey1.currentState!.validate()) {
                      cubit.searchMeals(searchController.text.trim(), context);
                      searchController.clear();
                      cubit.removeShownData();
                    }
                  },
                  suffixIcon: Icons.close,
                  hint: 'write meal name',
                  suffixFunction: () {
                    searchController.clear();
                  },
                  controller: searchController,
                  validate: (String? value) {
                    return GlobalMethods.validate('write to search', value);
                  }),
              SizedBox(
                height: AppSize.s14,
              ),
              if (cubit.removeData == true)
                DefaultButton(
                    text: 'Remove Data',
                    function: () {
                      cubit.removeShownData();
                    },
                    context: context),
              SizedBox(
                height: AppSize.s14,
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    switch (state.runtimeType) {
                      case LoadingState:
                        return DefaultCustomText(
                          text: AppStrings.loading,
                          alignment: Alignment.center,
                        );
                      case SuccessState:
                        if (cubit.mealFilter?.meals != null &&
                            cubit.removeData) {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              var data = cubit.mealFilter?.meals![index];
                              return GestureDetector(
                                onTap: () {
                                  appCubit
                                      .getMealDetails(data!.mealId!)
                                      .then((value) {
                                    GlobalMethods.navigateTo(
                                        context, const MealDetails());
                                  });
                                },
                                child: FavouriteItem(
                                  name: data?.mealName,
                                  color: Colors.black,
                                  image: data?.mealImage,
                                ),
                              );
                            },
                            itemCount: cubit.mealFilter?.meals!.length,
                          );
                        } else {
                          return const EmptyScreen(
                            text: AppStrings.errorMessage,
                            image: Assets.imagesNoPage,
                          );
                        }
                      case ErrorState:
                        return const EmptyScreen(
                          text: AppStrings.errorMessage,
                          image: Assets.imagesNoPage,
                        );
                    }
                    return const EmptyScreen(
                      text: 'Start Searching Now 🔎',
                      image: Assets.imagesSearch,
                    );
                  },
                  itemCount: 1,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
