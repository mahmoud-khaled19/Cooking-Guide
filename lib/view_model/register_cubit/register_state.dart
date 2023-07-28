abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterWithEmailAndPasswordLoadingState extends RegisterState {}

class RegisterWithEmailAndPasswordSuccessState extends RegisterState {}

class RegisterWithEmailAndPasswordErrorState extends RegisterState {}

class AddUserDataToFirebaseSuccessState extends RegisterState {}

class ChangeVisibilityState extends RegisterState {}
