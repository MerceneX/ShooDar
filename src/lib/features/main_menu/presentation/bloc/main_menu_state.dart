import 'package:equatable/equatable.dart';

abstract class MainMenuState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoggedIn extends MainMenuState {

  LoggedIn();
  List<Object> get props => [];
}

class LoggedOut extends MainMenuState {

  LoggedOut();
  List<Object> get props => [];
}

class NavigationState extends MainMenuState {
  final int current;

  NavigationState({this.current});
  List<Object> get props => [current];
}