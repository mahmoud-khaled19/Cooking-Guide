import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/generated/assets.dart';
import 'package:food_app/view/components/meal_item_shape.dart';
import 'package:food_app/view/empty_screen.dart';
import 'package:food_app/view_model/app_cubit/app_cubit.dart';
import 'package:food_app/widgets/default_custom_text.dart';
import '../../utils/strings_manager.dart';
import '../../view_model/app_cubit/app_state.dart';

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
                .where('userId', isEqualTo: cubit.auth.currentUser?.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: DefaultCustomText(
                    alignment: Alignment.center,
                    text: AppStrings.loading,
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  var data = snapshot.data!.docs;
                  return GridView.count(
                    crossAxisCount: 2,
                    physics: const BouncingScrollPhysics(),
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 10,
                    children: List.generate(data.length, (index) {
                      return Stack(
                        alignment: Alignment.topRight,
                        children: [
                          FavouriteItem(
                              color: Colors.black,
                              name: data[index]['mealName'],
                              image: data[index]['image']),
                          GestureDetector(
                            onTap: (){
                              cubit.deleteFavourite(
                                  data[index]['mealId'], context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Icon(Icons.delete,color: Colors.red,),
                            ),
                          )
                        ],
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
                text: 'No Favourites yet !',
                image: Assets.imagesFavourites,
              );
            });
      },
    );
  }

}
