import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:shoodar/core/error/failure.dart';
import 'package:shoodar/features/user/domain/usecases/login_user.dart';
import 'package:shoodar/features/user/domain/usecases/register_user.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

import 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  final LoginUser loginUser;
  final RegisterUser registerUser;

  UserBloc({
    @required LoginUser login,
    @required RegisterUser register
  })  : assert(login != null),
        assert(register != null),
        loginUser = login,
        registerUser = register;


  @override
  UserState get initialState => InitialUserState();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is RegisterUserEvent) {
      final failureOrSucces = await registerUser(Params(email: event.email, password: event.password));
      yield* _eitherSuccessOrErrorState(failureOrSucces);
    }
    else if(event is LoginUserEvent){
      final failureOrSucces = await loginUser(Params(email: event.email, password: event.password));
      yield* _eitherSuccessOrErrorState(failureOrSucces);
    }
  }

  Stream<UserState> _eitherSuccessOrErrorState(
    Either<Failure, bool> failureOrSuccess,
  ) async* {
    yield failureOrSuccess.fold(
      (failure) => Error(message: failure.message),
      (success) => AuthSuccess(),
    );
  }
}