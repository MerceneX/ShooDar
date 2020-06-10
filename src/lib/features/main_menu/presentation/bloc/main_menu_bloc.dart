import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shoodar/core/usecases/usecase.dart';
import 'package:shoodar/features/main_menu/domain/usecases/is_user_logged_in.dart';
import 'package:shoodar/features/main_menu/domain/usecases/logout_user.dart';
import './bloc.dart';

import 'main_menu_event.dart';

class MainMenuBloc extends Bloc<MainMenuEvent, MainMenuState> {

  final IsUserLoggedIn isUserLoggedIn;
  final LogoutUser logoutUser;

  MainMenuBloc({@required IsUserLoggedIn isUserLoggedIn, @required LogoutUser logoutUser})
      : assert(isUserLoggedIn != null),
        assert(logoutUser != null),
        isUserLoggedIn = isUserLoggedIn,
        logoutUser = logoutUser;
        
  @override
  MainMenuState get initialState => NavigationState(current: 1);

  @override
  Stream<MainMenuState> mapEventToState(
    MainMenuEvent event,
  ) async* {
    
    if (event is LogOutEvent) {
      await logoutUser(NoParams());
    }
    if (event is RefreshEvent) {
      final loggedIn = await isUserLoggedIn(NoParams());

      if(loggedIn ==true) yield LoggedIn();
      else yield LoggedOut();
    } 
    else if (event is ChangePageEvent) {
      yield NavigationState(current: event.page);
    }
  }
}