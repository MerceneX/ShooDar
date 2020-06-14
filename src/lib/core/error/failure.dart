import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.

  List properties;
  String message;
  Failure([properties = const <dynamic>[]]);

  @override
  List<Object> get props => [properties];
}

class LoginFailure extends Failure {
  LoginFailure(String message) {
    super.message = message;
  }
}

class RegisterFailure extends Failure {
  RegisterFailure(String message) {
    super.message = message;
  }
}

class InvalidInputFailure extends Failure {
  InvalidInputFailure(String message) {
    super.message = message;
  }
}

class NoInputFailure extends Failure {}

class InvalidEmailFailure extends Failure {}
