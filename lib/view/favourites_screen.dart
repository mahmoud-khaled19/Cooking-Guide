import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/generated/assets.dart';
import 'package:food_app/utils/global_methods.dart';
import 'package:food_app/utils/values_manager.dart';
import 'package:food_app/view/components/item.dart';
import 'package:food_app/view/empty_screen.dart';
import 'package:food_app/view_model/app_cubit.dart';
import 'package:food_app/widgets/default_custom_text.dart';
import '../utils/strings_manager.dart';
import '../view_model/app_state.dart';
import 'components/meal_item.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of(context);
        return StreamBuilder<QuerySnapshot>(
            stream: cubit.authStore
                .collection('favourites')
                .where('userId', isEqualTo: cubit.auth.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              print(cubit.auth.currentUser!.uid);
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: DefaultCustomText(
                    alignment: Alignment.center,
                    text: AppStrings.loading,
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty ) {
                  var data = snapshot.data!.docs;
                  return GridView.count(
                    padding: EdgeInsets.all(AppSize.s8),
                    crossAxisCount: 2,
                    physics: const BouncingScrollPhysics(),
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 10,
                    children: List.generate(data.length, (index) {
                      return GestureDetector(
                        onLongPress: () {
                           removeFavourite(context, () {
                            cubit.deleteFavourite(data[index]['mealId'],context);
                          });
                        },
                        onTap: () {
                          GlobalMethods.navigateTo(
                              context,
                              MealItem(
                                mealName: data[index]['mealName'],
                                mealInstructions: data[index]
                                    ['mealInstructions'],
                                mealCountry: data[index]['mealCountry'],
                                source: data[index]['source'],
                                image: data[index]['image'],
                                videoUrl: data[index]['videoUrl'],
                                items: data[index]['items'],
                                quantity: data[index]['quantity'],
                              ));
                        },
                        child: FavouriteItem(
                            color: Colors.black,
                            name: data[index]['mealName'],
                            image: data[index]['image']),
                      );
                    }),
                  );
                } else if (snapshot.hasError) {
                  return EmptyScreen(
                    text: AppStrings.errorMessage,
                    image: Assets.imagesFavourites,
                  );
                }
              }
              return const EmptyScreen(
                text: 'No Favourites, go back and Search',
                image: Assets.imagesFavourites,
              );
            });
      },
    );
  }

  removeFavourite(context, Function() function) {
    GlobalMethods.showAlertDialog(
        context: context,
        title: DefaultCustomText(text: 'Remove from Favourite?'),
        actions: [
          TextButton(
            onPressed: function,
            child: DefaultCustomText(
              text: 'Delete',
              color: Colors.lightBlue,
              alignment: Alignment.centerRight,
            ),
          )
        ]);
  }
}
