import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/view_model/register_cubit/register_state.dart';

import '../../utils/global_methods.dart';
import '../../view/auth_screens/login_screen.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  RegisterCubit get(context) => BlocProvider.of(context);
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore authStore = FirebaseFirestore.instance;

  Future userRegisterWithEmailAndPassword(
    context, {
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    emit(RegisterWithEmailAndPasswordLoadingState());
    await auth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      addUserDataToFirebase(
        name: name,
        phone: phone,
        password: password,
        email: email,
      );
      afterRegister(context);
      emit(RegisterWithEmailAndPasswordSuccessState());
    }).catchError((error) {
      GlobalMethods.showAlertDialog(
          context: context,
          title:  Text(error.toString()),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('ok')),
          ]);
      emit(RegisterWithEmailAndPasswordErrorState());
    });
  }

  bool isVisible = true;

  void changeVisibility() {
    isVisible = !isVisible;
    emit(ChangeVisibilityState());
  }

  void afterRegister(context) {
    GlobalMethods.showSnackBar(
        context, 'Email Created Successfully', Colors.green);
    GlobalMethods.navigateTo(context, LoginScreen());
  }

  Future addUserDataToFirebase({
    required String name,
    required String phone,
    required String password,
    required String email,
  }) async {
    var id = auth.currentUser?.uid;
    await authStore.collection('users').doc(id).set({
      'name': name,
      'password': password,
      'email': email,
      'phone': phone,
      'uid': id,
    });
    emit(AddUserDataToFirebaseSuccessState());
  }
}
