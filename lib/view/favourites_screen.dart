import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/generated/assets.dart';
import 'package:food_app/view/empty_screen.dart';
import 'package:food_app/view_model/app_cubit.dart';
import '../view_model/app_state.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of(context);
        return const EmptyScreen(text: 'No Favourites, go back and Search',
          image: Assets.imagesFavourites,);
      },
    );
  }
}
