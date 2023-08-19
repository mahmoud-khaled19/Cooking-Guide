import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/generated/assets.dart';
import 'package:food_app/utils/global_methods.dart';
import 'package:food_app/utils/strings_manager.dart';
import 'package:food_app/utils/values_manager.dart';
import 'package:food_app/view/auth_screens/register_screen.dart';
import 'package:food_app/view/auth_screens/forget_password_screen.dart';
import 'package:food_app/view_model/login_cubit/login_cubit.dart';
import 'package:food_app/widgets/default_custom_text.dart';
import 'package:food_app/widgets/elevated_button_widget.dart';
import 'package:food_app/widgets/text_form_field_widget.dart';
import '../../view_model/login_cubit/login_state.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final hSize = MediaQuery.sizeOf(context).height;
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        LoginCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Form(
                      key: formKey,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        padding: EdgeInsets.symmetric(horizontal: hSize * 0.02),
                        margin: EdgeInsets.symmetric(horizontal: hSize * 0.03),
                        height: hSize * 0.7,
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            SizedBox(
                              height: AppSize.s30,
                            ),
                            DefaultCustomText(
                              text: 'Welcome !',
                              alignment: Alignment.center,
                              color: Theme.of(context).splashColor,
                              fontSize: AppSize.s20,
                            ),
                            DefaultCustomText(
                              alignment: Alignment.center,
                              text: 'sign in to continue',
                              color: Theme.of(context).splashColor,
                            ),
                            SizedBox(
                              height: AppSize.s20,
                            ),
                            DefaultTextFormField(
                              hint: AppStrings.labelEmail,
                              controller: emailController,
                              validate: (String? value) {
                                return GlobalMethods.validate(
                                    AppStrings.passwordValidateMessage, value);
                              },
                            ),
                            DefaultTextFormField(
                              textTypeAction: TextInputAction.done,
                              isSecure: cubit.isVisible,
                              controller: passwordController,
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
                                GlobalMethods.navigateTo(
                                    context, ForgetPasswordScreen());
                              },
                              child: DefaultCustomText(
                                color: Theme.of(context).splashColor,
                                alignment: Alignment.centerRight,
                                text: 'forget your password?',
                                fontSize: AppSize.s10,
                              ),
                            ),
                            SizedBox(
                              height: AppSize.s14,
                            ),
                            Visibility(
                              replacement: const CircularProgressIndicator(),
                              visible: state
                                      is! SignInWithEmailAndPasswordLoadingState ||
                                  state is SignInWithEmailAndPasswordErrorState,
                              child: DefaultButton(
                                  text: AppStrings.login,
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.userLoginWithEmail(
                                          email: emailController.text.trim(),
                                          password: passwordController.text.trim(),
                                          context: context);
                                    }
                                  },
                                  context: context),
                            ),
                            SizedBox(
                              height: AppSize.s10,
                            ),
                            DefaultCustomText(
                              text: 'Or Login Using Google',
                              alignment: Alignment.center,
                              fontSize: AppSize.s12,
                              color: Colors.grey[800],
                            ),
                            SizedBox(
                              height: AppSize.s8,
                            ),
                            GestureDetector(
                              onTap: () {
                                cubit.signInWithGoogle(context);
                              },
                              child: CircleAvatar(
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
                              height: AppSize.s20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DefaultCustomText(
                                  text: AppStrings.dontHaveAccount,
                                  fontWeight: FontWeight.normal,
                                  color: Theme.of(context).splashColor,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    GlobalMethods.navigateAndFinish(
                                        context, RegisterScreen());
                                  },
                                  child: DefaultCustomText(
                                    text: AppStrings.register,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context).splashColor,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
