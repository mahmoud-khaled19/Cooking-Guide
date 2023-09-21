import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/view_model/register_cubit/register_cubit.dart';
import 'package:food_app/view_model/register_cubit/register_state.dart';
import '../../../utils/global_methods.dart';
import '../../../utils/strings_manager.dart';
import '../../../utils/style_manager.dart';
import '../../../utils/values_manager.dart';
import '../../../widgets/default_custom_text.dart';
import '../../../widgets/elevated_button_widget.dart';
import '../../../widgets/text_form_field_widget.dart';
import '../login/login_screen.dart';

class RegisterBody extends StatelessWidget {
  RegisterBody({
    Key? key,
    this.emailController,
    this.nameController,
    this.passwordController,
    this.confirmPasswordController,
    this.emailFocusNode,
    this.passwordFocusNode,
    this.nameFocusNode,
    this.confirmPasswordFocusNode,
    this.textChangedFunction,
  }) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final TextEditingController? emailController;
  final TextEditingController? nameController;
  final TextEditingController? confirmPasswordController;
  final TextEditingController? passwordController;
  final FocusNode? emailFocusNode;
  final FocusNode? passwordFocusNode;
  final FocusNode? confirmPasswordFocusNode;
  final FocusNode? nameFocusNode;
  final Function(String? val)? textChangedFunction;

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.sizeOf(context).height;
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        RegisterCubit cubit = BlocProvider.of(context);
        return Center(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 4,
                ),
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20)),
            padding: EdgeInsets.symmetric(horizontal: size * 0.02),
            margin: EdgeInsets.symmetric(horizontal: size * 0.03),
            height: size * 0.64,
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
                  text: AppStrings.registerScreenMessage,
                  fontSize: AppSize.s16,
                  fontWeight: FontWeightManager.light,
                ),
                DefaultTextFormField(
                  onChanged: textChangedFunction,
                  textTypeAction: TextInputAction.next,
                  focusNode: nameFocusNode,
                  controller: nameController!,
                  validate: (String? value) {
                    return GlobalMethods.validate(
                        AppStrings.nameValidateMessage, value);
                  },
                  hint: AppStrings.labelName,
                ),
                DefaultTextFormField(
                  onChanged: textChangedFunction,
                  textTypeAction: TextInputAction.next,
                  focusNode: emailFocusNode,
                  controller: emailController!,
                  validate: (String? value) {
                    return GlobalMethods.validate(
                        AppStrings.emailValidateMessage, value);
                  },
                  hint: AppStrings.labelEmail,
                ),
                DefaultTextFormField(
                  textTypeAction: TextInputAction.next,
                  focusNode: passwordFocusNode,
                  isSecure: cubit.isVisible,
                  controller: passwordController!,
                  suffixIcon:
                      cubit.isVisible ? Icons.visibility_off : Icons.visibility,
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
                  focusNode: confirmPasswordFocusNode,
                  isSecure: true,
                  textTypeAction: TextInputAction.done,
                  controller: confirmPasswordController!,
                  validate: (String? value) {
                    return GlobalMethods.validate(
                        AppStrings.confirmedPasswordValidateMessage, value);
                  },
                  hint: AppStrings.labelPassword,
                ),
                SizedBox(
                  height: AppSize.s12,
                ),
                Visibility(
                  visible: state is! RegisterWithEmailAndPasswordLoadingState ||
                      state is RegisterWithEmailAndPasswordErrorState,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: DefaultButton(
                    text: AppStrings.register,
                    function: () {
                      if (checkFields(context) == true) {
                        cubit.userRegisterWithEmailAndPassword(
                          context,
                          name: nameController!.text.trim(),
                          password: passwordController!.text.trim(),
                          email: emailController!.text.trim(),
                        );
                      }
                      return null;
                    },
                    context: context,
                  ),
                ),
                SizedBox(
                  height: AppSize.s10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultCustomText(
                      text: AppStrings.alreadyHaveAccount,
                      fontWeight: FontWeight.normal,
                    ),
                    GestureDetector(
                      onTap: () {
                        GlobalMethods.navigateAndFinish(context, LoginScreen());
                      },
                      child: DefaultCustomText(
                        text: AppStrings.login,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  checkFields(context) {
    if (emailController!.text.isEmpty ||
        passwordController!.text.isEmpty ||
        confirmPasswordController!.text.isEmpty ||
        nameController!.text.isEmpty) {
      return GlobalMethods.showAlertDialog(
          context: context,
          title: DefaultCustomText(text: 'Error'),
          content: Container(
            child: DefaultCustomText(text: 'Complete The All Fields '),
            height: AppSize.s30,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: DefaultCustomText(
                  text: 'Ok',
                  alignment: Alignment.centerRight,
                ))
          ]);
    } else if (passwordController!.text != confirmPasswordController!.text) {
      return GlobalMethods.showAlertDialog(
          context: context,
          title: DefaultCustomText(text: 'Error'),
          content: Container(
            child: DefaultCustomText(text: 'check your password again !'),
            height: AppSize.s30,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: DefaultCustomText(
                  text: 'Ok',
                  alignment: Alignment.centerRight,
                ))
          ]);
    }
    return true;
  }
}
