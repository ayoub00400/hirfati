part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class UserLogedIn extends LoginState {
}
class UserNotLogedIn extends LoginState {
}

class LoginLoading extends LoginState {
}



class LoginFailed extends LoginState {
String error;
LoginFailed(this.error);
}
////////////////////


class LoginDoneUserNotVerified extends LoginState {
}
class LoginDoneUserVerified extends LoginState {
}

class RegisterLoading extends LoginState {
}


class RegisterDone extends LoginState {

}
class RegisterFailed extends LoginState {
String error;
RegisterFailed(this.error);
}












 
