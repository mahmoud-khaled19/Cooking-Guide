import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/generated/assets.dart';
import 'package:food_app/view/main_screens/layout_screen.dart';
import '../../utils/strings_manager.dart';
import '../../view_model/login_cubit/login_cubit.dart';
import '../../view_model/login_cubit/login_state.dart';
import '../empty_screen.dart';
import 'login_screen.dart';

class UserLoginStates extends StatelessWidget {
  const UserLoginStates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        LoginCubit cubit = BlocProvider.of(context);
        return StreamBuilder(
            stream: cubit.auth.authStateChanges(),
            builder: (context, userSnapshot) {
              if (userSnapshot.data == null) {
                return LoginScreen();
              } else if (userSnapshot.hasData) {
                return const LayoutScreen();
              } else if (userSnapshot.hasError) {
                return EmptyScreen(
                    text: AppStrings.errorMessage, image: Assets.imagesNoPage);
              }
              return const Scaffold(
                body: Center(
                  child: Text('Restart The App'),
                ),
              );
            });
      },
    );
  }
}
