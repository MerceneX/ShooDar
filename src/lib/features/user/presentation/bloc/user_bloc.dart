import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

import 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  @override
  UserState get initialState => InitialUserState();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
 
  }
}




