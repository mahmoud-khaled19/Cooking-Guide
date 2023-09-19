abstract class LoginState {}

class LoginInitial extends LoginState {}

class SignOutSuccessState extends LoginState {}

class DeleteSuccessState extends LoginState {}

class GetUserDataSuccessState extends LoginState {}

class ResetPasswordLoadingPassword extends LoginState {}

class ResetPasswordSuccessPassword extends LoginState {}

class SignInWithGoogleLoadingState extends LoginState {}

class SignInWithGoogleSuccessState extends LoginState {}

class SignInWithGoogleErrorState extends LoginState {}

class SignInWithGmailAndPasswordSuccessState extends LoginState {}

class SignInWithEmailAndPasswordLoadingState extends LoginState {}

class ChangeVisibilityState extends LoginState {}

class SignInWithEmailAndPasswordSuccessState extends LoginState {}

class SignInWithEmailAndPasswordErrorState extends LoginState {

}
