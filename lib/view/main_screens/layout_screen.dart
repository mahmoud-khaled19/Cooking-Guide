import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/utils/strings_manager.dart';
import 'package:food_app/utils/values_manager.dart';
import 'package:food_app/view_model/app_cubit/app_cubit.dart';
import 'package:food_app/view_model/home_layout_view_model.dart';
import 'package:food_app/widgets/default_custom_text.dart';
import '../../utils/global_methods.dart';
import '../../view_model/app_cubit/app_state.dart';
import '../../view_model/login_cubit/login_cubit.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of(context);
        LoginCubit loginCubit = BlocProvider.of(context);

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              HomeLayoutViewModel.screensTitle[cubit.currentPage],
            ),
            actions: [
              PopupMenuButton<int>(
                onSelected: (val) {},
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                      value: 0,
                      child: GestureDetector(
                        onTap: () {
                          loginCubit.signOut(context);
                        },
                        child: DefaultCustomText(
                          text: AppStrings.signOut,
                          color: Theme.of(context).splashColor,
                          alignment: Alignment.center,
                        ),
                      )),
                  PopupMenuItem<int>(
                    value: 1,
                    child: GestureDetector(
                      onTap: () {
                        loginCubit.deleteUser(context);
                      },
                      child: DefaultCustomText(
                        text: 'Delete Account',
                        color: Theme.of(context).splashColor,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 2,
                    child: GestureDetector(
                      onTap: () {
                        GlobalMethods.openWhatsApp('+971581077302');
                      },
                      child: DefaultCustomText(
                        text: 'Chat With Dev',
                        color: Theme.of(context).splashColor,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 3,
                    child: GestureDetector(
                      onTap: () {
                        GlobalMethods.mailTo('mahmoudacc.97@gmail.com');
                      },
                      child: DefaultCustomText(
                        text: 'Mail Support',
                        color: Theme.of(context).splashColor,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottomNavigationBar: CurvedNavigationBar(
            height: 60.00,
            backgroundColor: Theme.of(context).splashColor,
            onTap: (index) {
              cubit.changeScreen(index);
            },
            items: const [
              Icon(Icons.home, size: 30),
              Icon(Icons.search, size: 30),
              Icon(Icons.favorite, size: 30),
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
