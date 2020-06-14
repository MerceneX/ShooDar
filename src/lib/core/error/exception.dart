class LoginException implements Exception {
  String message;

  LoginException(String message){
    this.message = message;
  }
}

class RegisterException implements Exception {
  String message;

  RegisterException(String message){
    this.message = message;
  }
}

class FormatException implements Exception {
  String message;

  FormatException(String message){
    this.message = message;
  }
}