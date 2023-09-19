import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/utils/values_manager.dart';
import 'package:food_app/view_model/app_cubit/app_cubit.dart';
import 'package:food_app/view_model/app_cubit/app_state.dart';
import 'package:food_app/widgets/default_custom_text.dart';
import '../../utils/global_methods.dart';
import '../../utils/strings_manager.dart';
import '../../view_model/login_cubit/login_cubit.dart';
import '../../widgets/default_list_tile.dart';
import '../../widgets/pop_menu_widget.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of(context);
        LoginCubit loginCubit = BlocProvider.of(context);
        return Column(
          children: [
            DefaultCustomText(
              text: 'Hello, ${loginCubit.userName}',
              fontSize: AppSize.s14,
              alignment: Alignment.center,
            ),
            SizedBox(
              height: AppSize.s30,
            ),
            DefaultListTile(
                title: AppStrings.mode,
                trailingWidget: DefaultPopMenuWidget(
                  itemOneFunction: () {
                    return cubit.changeAppModeState(appMode: false);
                  },
                  itemTwoFunction: () {
                    return cubit.changeAppModeState(appMode: true);
                  },
                  itemOneText: AppStrings.lightMode,
                  itemTwoText: AppStrings.darkMode,
                ),
                function: () {},
                leadingWidget: const Icon(Icons.brightness_4)),
            const Divider(
              thickness: 2,
            ),
            DefaultListTile(
                title: AppStrings.contactUs,
                trailingWidget: DefaultPopMenuWidget(
                  itemOneFunction: () {
                    return GlobalMethods.openWhatsApp('+201025524651');
                  },
                  itemTwoFunction: () {
                    return GlobalMethods.mailTo('mahmoudacc.97@gmail.com');
                  },
                  itemOneText: AppStrings.chatUs,
                  itemTwoText: AppStrings.mailUs,
                ),
                function: () {},
                leadingWidget: const Icon(Icons.chat)),
            const Divider(
              thickness: 2,
            ),
            DefaultListTile(
                title: AppStrings.signOut,
                function: () {
                  loginCubit.signOut(context).then((value) {
                    cubit.currentPage = 0 ;
                  });
                },
                trailingWidget: const Icon(Icons.arrow_forward_ios_outlined),
                leadingWidget: const Icon(Icons.logout)),
            const Divider(
              thickness: 2,
            ),
            DefaultListTile(
                title: AppStrings.delete,
                function: () {
                  loginCubit.deleteUser(context);
                },
                trailingWidget: const Icon(Icons.arrow_forward_ios_outlined),
                leadingWidget: const Icon(Icons.delete)),
            const Divider(
              thickness: 2,
            ),
          ],
        );
      },
    );
  }
}
