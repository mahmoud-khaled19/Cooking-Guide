import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/utils/colors_manager.dart';
import 'package:food_app/utils/values_manager.dart';
import 'package:food_app/view_model/app_cubit/app_cubit.dart';
import 'package:food_app/view_model/home_layout_view_model.dart';
import '../../view_model/app_cubit/app_state.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              HomeLayoutViewModel.screensTitle[cubit.currentPage],
            ),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            color:Theme.of(context).scaffoldBackgroundColor ,
            height: 60.00,
            backgroundColor: Theme.of(context).cardColor,
            onTap: (index) {
              cubit.changeScreen(index);
            },
            items: const [
              Icon(Icons.home, size: 30),
              Icon(Icons.search, size: 30),
              Icon(Icons.favorite, size: 30),
              Icon(Icons.account_circle, size: 30),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(AppSize.s10),
            child: HomeLayoutViewModel.screens[cubit.currentPage],
          ),
        );
      },
    );
  }
}
