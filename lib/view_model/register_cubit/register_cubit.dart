import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/view/auth_screens/login/login_screen.dart';
import 'package:food_app/view_model/register_cubit/register_state.dart';
import '../../utils/global_methods.dart';

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
  }) async {
    emit(RegisterWithEmailAndPasswordLoadingState());
    await auth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      addUserDataToFirebase(
        name: name,
        password: password,
        email: email,
      );
      GlobalMethods.navigateAndFinish(context, LoginScreen());
      emit(RegisterWithEmailAndPasswordSuccessState());
    }).catchError((error) {
      emit(RegisterWithEmailAndPasswordErrorState());
      GlobalMethods.showErrorMessage(error, context);
    });
  }

  bool isVisible = true;

  void changeVisibility() {
    isVisible = !isVisible;
    emit(ChangeVisibilityState());
  }

  Future addUserDataToFirebase({
    required String name,
    required String password,
    required String email,
  }) async {
    var id = auth.currentUser?.uid;
    await authStore.collection('users').doc(id).set({
      'name': name,
      'password': password,
      'email': email,
      'uid': id,
    });
    emit(AddUserDataToFirebaseSuccessState());
  }
}
