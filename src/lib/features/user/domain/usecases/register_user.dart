import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shoodar/core/error/failure.dart';
import 'package:shoodar/core/usecases/usecase.dart';
import 'package:shoodar/features/user/domain/repositories/user_repository.dart';

class RegisterUser implements UseCaseWithFailure<bool, Params> {
  final UserRepository repository;

  RegisterUser(this.repository);

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.registerUser(params.email, params.password);
  }
}

class Params extends Equatable {
  final String email;
  final String password;

  Params({this.email, this.password});

  @override
  List<Object> get props => [email, password];
}