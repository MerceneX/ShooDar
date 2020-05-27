import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoginUserEvent extends UserEvent {
  final String email;
  final String password;

  LoginUserEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class RegisterUserEvent extends UserEvent {
  final String email;
  final String password;

  RegisterUserEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
