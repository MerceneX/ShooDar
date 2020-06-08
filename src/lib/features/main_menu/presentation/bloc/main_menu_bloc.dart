import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

import 'main_menu_event.dart';

class MainMenuBloc extends Bloc<MainMenuEvent, MainMenuState> {
  @override
  MainMenuState get initialState => NavigationState(current: 1);

  @override
  Stream<MainMenuState> mapEventToState(
    MainMenuEvent event,
  ) async* {
    if (event is UnlockEvent) {
      yield Unlocked(locked: false);
    } else if (event is ChangePageEvent) {
      yield NavigationState(current: event.page);
    }
  }
}
