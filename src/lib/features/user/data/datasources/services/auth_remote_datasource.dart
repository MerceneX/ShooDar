import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoodar/core/error/exception.dart';

abstract class AuthRemoteDataSource {
  Future<bool> loginUser(String email, String password);
  Future<bool> registerUser(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<bool> loginUser(String email, String password) async {
    try {
      var user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if(user != null){
        return true;
      }
      else{
        throw LoginException("Registration failed!");
      }
    } catch (e) {
      throw LoginException(e.message);
    }
  }

  @override
  Future<bool> registerUser(String email, String password) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if(authResult != null){
        return true;
      }
      else{
        throw RegisterException("Registration failed!");
      }
    } catch (e) {
      throw RegisterException(e.message);
    }
  }
}