import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/global_methods.dart';
import '../../view/layout_screen.dart';
import '../../widgets/default_custom_text.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  LoginCubit get(context) => BlocProvider.of(context);
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore authStore = FirebaseFirestore.instance;
  bool isVisible = true;

  void changeVisibility() {
    isVisible = !isVisible;
    emit(ChangeVisibilityState());
  }

  Future userLoginWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    emit(SignInWithEmailAndPasswordLoadingState());
    await auth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      GlobalMethods.showSnackBar(
          context, 'Logged in Successfully', Colors.green);
      GlobalMethods.navigateAndFinish(context, const LayoutScreen());
      emit(SignInWithEmailAndPasswordSuccessState());
    }).catchError((error) {
      emit(SignInWithEmailAndPasswordErrorState(error: error.toString()));
      GlobalMethods.showAlertDialog(
          context: context,
          title: Text(error.toString()),
          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const DefaultCustomText(
                  alignment: Alignment.centerRight,
                  text: 'ok',
                  color: Colors.red,
                )),
          ]);
    });
  }

  Future signOut() async {
    auth.signOut();
    emit(SignOutSuccessState());
  }
}
