import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoodar/core/error/exception.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResult> loginUser(String email, String password);
  Future<AuthResult> registerUser(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<AuthResult> loginUser(String email, String password) async {
    try {
      var user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      if(user != null){
        return user;   
      }
      else{
        throw LoginException("Registration failed!");
      }
    } catch (e) {
      throw LoginException(e.message);
    }
  }

  @override
  Future<AuthResult> registerUser(String email, String password) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      
      if(authResult != null){
        return authResult;
      }
      else{
        throw RegisterException("Registration failed!");
      }
    } catch (e) {
      throw RegisterException(e.message);
    }
  }
}