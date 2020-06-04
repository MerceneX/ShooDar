import 'package:dartz/dartz.dart';
import 'package:shoodar/core/error/failure.dart';

Either<Failure, bool> emailValidator(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (value == null || value.isEmpty) return Left(NoInputFailure());
  if (!regex.hasMatch(value))
    return Left(InvalidEmailFailure());
  else
    return Right(true);
}

Either<Failure, bool> passwordValidator(String value) {
  if (value == null || value.isEmpty) return Left(NoInputFailure());
  return Right(true);
}

Either<Failure, bool> emptyInputValidator(String value) {
  if (value == null || value.isEmpty) return Left(NoInputFailure());
  return Right(true);
}
