import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialUserState extends UserState {}

class AuthSuccess extends UserState {
  AuthSuccess();
  List<Object> get props => [];
}

class RegistrationValidationErrorState extends UserState {
  final String emailError;
  final String passwordError;
  RegistrationValidationErrorState({this.emailError, this.passwordError});

  List<Object> get props => [
        emailError,
        passwordError,
      ];
}

class Error extends UserState {
  final String message;

  Error({this.message});
  List<Object> get props => [message];
}

class LoginValidationErrorState extends UserState {
  final String emailError;
  final String passwordError;
  LoginValidationErrorState({this.emailError, this.passwordError});

  List<Object> get props => [
        emailError,
        passwordError,
      ];
}
