import 'package:dartz/dartz.dart';
import 'package:shoodar/core/error/failure.dart';
import 'package:shoodar/core/usecases/usecase.dart';
import 'package:shoodar/features/user/domain/repositories/user_repository.dart';
import 'package:shoodar/features/user/domain/usecases/register_user.dart';

class LoginUser implements UseCaseWithFailure<bool, Params> {
  final UserRepository repository;

  LoginUser(this.repository);

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.loginUser(params.email, params.password);
  }
}