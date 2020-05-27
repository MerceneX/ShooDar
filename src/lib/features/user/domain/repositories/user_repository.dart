import 'package:dartz/dartz.dart';
import 'package:shoodar/core/error/failure.dart';
import 'package:shoodar/features/user/domain/entities/user_location.dart';

abstract class UserRepository {
  Future<UserLocation> getCurrentLocation();

  Future<Either<Failure, bool>> registerUser(String email, String password);
  Future<Either<Failure, bool>> loginUser(String email, String password);
}
