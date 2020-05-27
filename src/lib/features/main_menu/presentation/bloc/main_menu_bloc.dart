import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

import 'main_menu_event.dart';

class MainMenuBloc extends Bloc<MainMenuEvent, MainMenuState> {

  @override
  MainMenuState get initialState => InitialMainMenuState();

  @override
  Stream<MainMenuState> mapEventToState(
    MainMenuEvent event,
  ) async* {
    if (event is UnlockEvent) {
      yield Unlocked(locked: false);
    }
  }
}