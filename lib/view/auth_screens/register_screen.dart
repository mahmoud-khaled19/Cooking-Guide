import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/view_model/register_cubit/register_cubit.dart';
import 'package:food_app/view_model/register_cubit/register_state.dart';
import '../../utils/global_methods.dart';
import '../../utils/strings_manager.dart';
import '../../utils/values_manager.dart';
import '../../widgets/default_custom_text.dart';
import '../../widgets/elevated_button_widget.dart';
import '../../widgets/text_form_field_widget.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        RegisterCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Expanded(
                     child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        padding: EdgeInsets.symmetric(horizontal: size * 0.02),
                        margin: EdgeInsets.symmetric(horizontal: size * 0.03),
                        height: size * 0.7,
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            SizedBox(
                              height: AppSize.s20,
                            ),
                            DefaultCustomText(
                              text: 'Welcome !',
                              alignment: Alignment.center,
                              color: Theme.of(context).splashColor,
                              fontSize: AppSize.s20,
                            ),
                            DefaultCustomText(
                              color: Theme.of(context).splashColor,
                              alignment: Alignment.center,
                              text: AppStrings.registerScreenMessage,
                              fontSize: AppSize.s16,
                            ),
                            SizedBox(
                              height: AppSize.s10,
                            ),
                            DefaultTextFormField(
                              controller: nameController,
                              validate: (String? value) {
                                return GlobalMethods.validate(
                                    AppStrings.nameValidateMessage, value);
                              },
                              hint: AppStrings.labelName,
                            ),
                            DefaultTextFormField(
                              controller: emailController,
                              validate: (String? value) {
                                return GlobalMethods.validate(
                                    AppStrings.emailValidateMessage, value);
                              },
                              hint: AppStrings.labelEmail,
                            ),
                            DefaultTextFormField(
                              isSecure: cubit.isVisible,
                              controller: passwordController,
                              suffixFunction: () {
                                cubit.changeVisibility();
                              },
                              validate: (String? value) {
                                return GlobalMethods.validate(
                                    AppStrings.passwordValidateMessage, value);
                              },
                              hint: AppStrings.labelPassword,
                            ),
                            DefaultTextFormField(
                              isSecure: cubit.isVisible,
                              textTypeAction: TextInputAction.done,
                              suffixIcon: cubit.isVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              suffixFunction: () {
                                cubit.changeVisibility();
                              },
                              controller: confirmPasswordController,
                              validate: (String? value) {
                                return GlobalMethods.validate(
                                    AppStrings.confirmedPasswordValidateMessage, value);
                              },
                              hint: AppStrings.labelPassword,
                            ),
                            SizedBox(
                              height: AppSize.s18,
                            ),
                            Visibility(
                              visible: state
                                      is! RegisterWithEmailAndPasswordLoadingState ||
                                  state
                                      is RegisterWithEmailAndPasswordErrorState,
                              replacement: const Center(
                                child: CircularProgressIndicator(),
                              ),
                              child: DefaultButton(
                                text: AppStrings.register,
                                function: () {
                                  if (formKey.currentState!.validate() &&
                                      cubit.confirmPassword(
                                        passwordController.text,
                                        confirmPasswordController.text,
                                      )) {
                                    cubit
                                        .userRegisterWithEmailAndPassword(
                                      context,
                                      name: nameController.text.trim(),
                                      password: passwordController.text.trim(),
                                      email: emailController.text.trim(),
                                    )
                                        .then((value) {
                                      emailController.clear();
                                    });
                                  }
                                },
                                context: context,
                              ),
                            ),
                            SizedBox(
                              height: AppSize.s18,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DefaultCustomText(
                                  text: AppStrings.alreadyHaveAccount,
                                  fontWeight: FontWeight.normal,
                                  color: Theme.of(context).splashColor,

                                ),
                                GestureDetector(
                                  onTap: () {
                                    GlobalMethods.navigateAndFinish(
                                        context, LoginScreen());
                                  },
                                  child: DefaultCustomText(
                                    text: AppStrings.login,
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

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
