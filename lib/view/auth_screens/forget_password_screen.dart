import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/utils/global_methods.dart';
import 'package:food_app/utils/strings_manager.dart';
import 'package:food_app/utils/values_manager.dart';
import 'package:food_app/view/auth_screens/login/login_body.dart';
import 'package:food_app/view_model/app_cubit/app_cubit.dart';
import 'package:food_app/view_model/app_cubit/app_state.dart';
import 'package:food_app/view_model/login_cubit/login_cubit.dart';
import 'package:food_app/view_model/login_cubit/login_state.dart';
import 'package:food_app/widgets/default_custom_text.dart';
import 'package:food_app/widgets/elevated_button_widget.dart';
import 'package:food_app/widgets/text_form_field_widget.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final hSize = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          LoginCubit cubit = BlocProvider.of(context);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(horizontal: hSize * 0.02),
                    margin: EdgeInsets.symmetric(horizontal: hSize * 0.03),
                    height: hSize * 0.5,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        SizedBox(
                          height: AppSize.s12,
                        ),
                        DefaultCustomText(
                          text: 'Forgot Password',
                          alignment: Alignment.center,
                          color: Theme.of(context).splashColor,
                          fontSize: AppSize.s16,
                        ),
                        DefaultCustomText(
                          text: 'Enter your Email for Verification Process,',
                          alignment: Alignment.center,
                          color: Theme.of(context).splashColor,
                          fontSize: AppSize.s12,
                        ),
                        DefaultCustomText(
                          text: 'you will receive a Link to set Password',
                          alignment: Alignment.center,
                          color: Theme.of(context).splashColor,
                          fontSize: AppSize.s12,
                        ),
                        SizedBox(
                          height: AppSize.s20,
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
                        SizedBox(
                          height: AppSize.s30,
                        ),
                        GestureDetector(
                          onTap: (){
                            GlobalMethods.navigateAndFinish(context, LoginBody());
                          },
                          child: DefaultCustomText(
                            text: 'Go Back',
                            alignment: Alignment.center,
                            color: Theme.of(context).splashColor,
                            fontSize: AppSize.s12,
                          ),
                        ),
                      ],
                    ),
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
