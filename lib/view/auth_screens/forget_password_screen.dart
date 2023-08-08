import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/utils/global_methods.dart';
import 'package:food_app/utils/strings_manager.dart';
import 'package:food_app/utils/values_manager.dart';
import 'package:food_app/view_model/app_cubit/app_cubit.dart';
import 'package:food_app/view_model/app_cubit/app_state.dart';
import 'package:food_app/view_model/login_cubit/login_cubit.dart';
import 'package:food_app/view_model/login_cubit/login_state.dart';
import 'package:food_app/widgets/default_custom_text.dart';
import 'package:food_app/widgets/elevated_button_widget.dart';
import 'package:food_app/widgets/text_form_field_widget.dart';

import '../components/clipper_class.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final hSize = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          LoginCubit cubit = BlocProvider.of(context);
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: hSize * 0.05,
              ),
              DefaultCustomText(
                text: 'Forget Password Screen',
                alignment: Alignment.center,
              ),
              ClipPath(
                clipper: ClipperPath(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: AppSize.s40),
                  height: hSize * 0.75,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        height: AppSize.s100,
                      ),
                      DefaultTextFormField(
                          hint: AppStrings.labelEmail,
                          controller: emailController,
                          suffixIcon: Icons.email,
                          validate: (String? value) {
                            return GlobalMethods.validate('text', value);
                          }),
                      SizedBox(
                        height: AppSize.s30,
                      ),
                      Visibility(
                        replacement: const CircularProgressIndicator(),
                        visible: state is! ResetPasswordLoadingPassword,
                        child: DefaultButton(
                            text: AppStrings.resetPassword,
                            function: () {
                              cubit.resetPassword(
                                  emailController.text.trim(), context);
                            },
                            context: context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
