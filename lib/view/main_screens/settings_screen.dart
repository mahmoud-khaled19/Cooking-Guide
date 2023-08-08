import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/utils/global_methods.dart';
import 'package:food_app/utils/values_manager.dart';
import 'package:food_app/view_model/login_cubit/login_cubit.dart';
import 'package:food_app/widgets/elevated_button_widget.dart';
import '../../view_model/login_cubit/login_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        LoginCubit cubit = BlocProvider.of(context);
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: DefaultButton(
                text: 'Sign Out',
                function: () {
                  cubit.signOut(context);
                },
                context: context,
              ),
            ),
            SizedBox(
              height: AppSize.s12,
            ),
            Center(
              child: DefaultButton(
                text: 'Delete Account',
                function: () {
                  cubit.deleteUser(context);
                },
                context: context,
              ),
            ),
            SizedBox(
              height: AppSize.s12,
            ),
            Center(
              child: DefaultButton(
                text: 'Chat With Dev',
                function: () {
                 GlobalMethods.openWhatsApp('+971581077302');
                },
                context: context,
              ),
            ),
            SizedBox(
              height: AppSize.s12,
            ),
            Center(
              child: DefaultButton(
                text: 'Mail Support',
                function: () {
                GlobalMethods.mailTo('mahmoudacc.97@gmail.com');
                },
                context: context,
              ),
            ),
          ],
        );
      },
    );
  }
}
