import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/generated/assets.dart';
import 'package:food_app/utils/global_methods.dart';
import 'package:food_app/utils/strings_manager.dart';
import 'package:food_app/utils/style_manager.dart';
import 'package:food_app/utils/values_manager.dart';
import 'package:food_app/view/auth_screens/forget_password_screen.dart';
import 'package:food_app/view/auth_screens/register/register_screen.dart';
import 'package:food_app/view_model/login_cubit/login_cubit.dart';
import 'package:food_app/widgets/default_custom_text.dart';
import 'package:food_app/widgets/elevated_button_widget.dart';
import 'package:food_app/widgets/text_form_field_widget.dart';
import '../../../view_model/login_cubit/login_state.dart';

class LoginBody extends StatelessWidget {
  LoginBody({
    Key? key,
     this.passwordController,
     this.passFocusNode,
     this.emailFocusNode,
     this.emailController,
     this.emailChangedFunction,
  }) : super(key: key);
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final FocusNode? emailFocusNode;
  final FocusNode? passFocusNode;
  final formKey = GlobalKey<FormState>();
  final Function(String? val)? emailChangedFunction;
  @override
  Widget build(BuildContext context) {
    final hSize = MediaQuery.sizeOf(context).height;
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        LoginCubit cubit = BlocProvider.of(context);
        log('rebuild login screen');
        return Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 4,
              ),
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.symmetric(horizontal: hSize * 0.02),
          margin: EdgeInsets.only(
            right: hSize * 0.03,
            left: hSize * 0.03,),
          height: hSize * 0.61,
          child: Column(
            children: [
              SizedBox(
                height: AppSize.s10,
              ),
              DefaultCustomText(
                text: 'Welcome !',
                alignment: Alignment.center,
                fontSize: AppSize.s20,
              ),
              DefaultCustomText(
                alignment: Alignment.center,
                text: 'sign in to continue',
                fontSize: AppSize.s16,
                fontWeight: FontWeightManager.light,
              ),
              DefaultTextFormField(
                textTypeAction: TextInputAction.next,
                onChanged: emailChangedFunction,
                focusNode: emailFocusNode,
                hint: AppStrings.labelEmail,
                controller: emailController!,
                validate: (String? value) {
                  return GlobalMethods.validate(
                      AppStrings.passwordValidateMessage, value);
                },
              ),
              DefaultTextFormField(
                focusNode: passFocusNode,
                textTypeAction: TextInputAction.done,
                isSecure: cubit.isVisible,
                controller: passwordController!,
                suffixIcon: cubit.isVisible
                    ? Icons.visibility_off
                    : Icons.visibility,
                suffixFunction: () {
                  cubit.changeVisibility();
                },
                validate: (String? value) {
                  return GlobalMethods.validate(
                      AppStrings.passwordValidateMessage, value);
                },
                hint: AppStrings.labelPassword,
              ),
              GestureDetector(
                onTap: () {
                  GlobalMethods.navigateTo(context, ForgetPasswordScreen());
                },
                child: DefaultCustomText(
                  alignment: Alignment.centerRight,
                  text: 'forget your password?',
                  fontSize: AppSize.s10,
                ),
              ),
              SizedBox(
                height: AppSize.s10,
              ),
              Visibility(
                replacement: const CircularProgressIndicator(),
                visible: state is! SignInWithEmailAndPasswordLoadingState ||
                    state is SignInWithEmailAndPasswordErrorState,
                child: DefaultButton(
                    text: AppStrings.login,
                    function: () {
                      cubit.userLoginWithEmail(
                          email: emailController!.text.trim(),
                          password: passwordController!.text.trim(),
                          context: context);
                    },
                    context: context),
              ),
              SizedBox(
                height: AppSize.s10,
              ),
              DefaultCustomText(
                text: AppStrings.or,
                alignment: Alignment.center,
                fontSize: AppSize.s12,
                color: Colors.grey[800],
              ),

              GestureDetector(
                onTap: () {
                  cubit.signInWithGoogle(context);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: Image(
                    fit: BoxFit.fill,
                    height: hSize * 0.05,
                    image: AssetImage(
                      Assets.imagesGmail,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: AppSize.s10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DefaultCustomText(
                    text: AppStrings.dontHaveAccount,
                    fontWeight: FontWeight.normal,
                  ),
                  GestureDetector(
                    onTap: () {
                      GlobalMethods.navigateAndFinish(
                          context, RegisterScreen());
                    },
                    child: DefaultCustomText(
                      text: AppStrings.register,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
