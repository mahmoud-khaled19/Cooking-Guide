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
import '../components/clipper_class.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController positionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        RegisterCubit cubit = BlocProvider.of(context);
        return Scaffold(
          body: SafeArea(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: size * 0.1,
                    ),
                    ClipPath(
                      clipper: ClipperPath(),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: AppSize.s40),
                        height: size * 0.8,
                        color: Colors.white,
                        child: Column(
                          children: [
                            SizedBox(
                              height: size * 0.06 ,
                            ),
                            DefaultCustomText(
                              alignment: Alignment.center,
                              text: AppStrings.register,
                              fontSize: AppSize.s20,
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
                              textType: TextInputType.phone,
                              controller: phoneController,
                              validate: (String? value) {
                                return GlobalMethods.validate(
                                    AppStrings.phoneValidateMessage, value);
                              },
                              hint: AppStrings.labelPhone,
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
                            SizedBox(
                              height: AppSize.s14,
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
                                width: AppSize.s100,
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit
                                        .userRegisterWithEmailAndPassword(
                                      context,
                                      name: nameController.text.trim(),
                                      phone: phoneController.text.trim(),
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
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DefaultCustomText(
                          text: AppStrings.alreadyHaveAccount,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: AppSize.s10,
                        ),
                        GestureDetector(
                          onTap: () {
                            GlobalMethods.navigateAndFinish(
                                context, LoginScreen());
                          },
                          child: DefaultCustomText(
                            text: AppStrings.login,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: AppSize.s12,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
