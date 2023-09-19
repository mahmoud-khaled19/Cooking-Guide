import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../utils/global_methods.dart';
import '../../view/auth_screens/user_login_states_screen.dart';
import '../../view/main_screens/layout_screen.dart';
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

  String? userName;

  Future getUserData() async {
    final userId = auth.currentUser?.uid;
    try {
      final DocumentSnapshot userDoc =
          await authStore.collection('users').doc(userId).get();
      if (userDoc.exists == true) {
        userName = userDoc.get('name');
        emit(GetUserDataSuccessState());
      }
      return;
    } catch (e) {
      print(e.toString());
    }
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
      GlobalMethods.navigateAndFinish(context, const LayoutScreen());
      emit(SignInWithEmailAndPasswordSuccessState());
    }).catchError((error) {
      emit(SignInWithEmailAndPasswordErrorState());
      GlobalMethods.showErrorMessage(error, context);
    });
  }

  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    emit(SignInWithGoogleLoadingState());
    try {
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(scopes: ['email']).signIn();

      if (googleUser == null) {
        return null;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      userName = userCredential.user!.displayName;
      // Successful sign-in
      emit(SignInWithGoogleSuccessState());
      GlobalMethods.navigateAndFinish(context, UserLoginStates());
      return userCredential;
    } catch (error) {
      print(error.toString());
      emit(SignInWithGoogleErrorState());
      return null;
    }
  }

  Future resetPassword(String email, context) async {
    emit(ResetPasswordLoadingPassword());
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((value) {
      emit(ResetPasswordSuccessPassword());
      GlobalMethods.showSnackBar(
          context, 'Email Send Successfully', Colors.green);
    }).catchError((error) {
      GlobalMethods.showSnackBar(context, 'write a valid Email', Colors.red);
      log(error.toString());
    });
  }

  Future signOut(context) async {
    auth.signOut().then((value) {
      GlobalMethods.navigateAndFinish(context, UserLoginStates());
    });
    emit(SignOutSuccessState());
  }

  Future deleteUser(context) async {
    auth.currentUser!.delete().then((value) {
      GlobalMethods.navigateAndFinish(context, UserLoginStates());
    });
    emit(DeleteSuccessState());
  }
}
