import 'package:equatable/equatable.dart';

abstract class MainMenuState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialMainMenuState extends MainMenuState {}

class Unlocked extends MainMenuState {
  final bool locked;

  Unlocked({this.locked});
  List<Object> get props => [locked];
}

class NavigationState extends MainMenuState {
  final int current;

  NavigationState({this.current});
  List<Object> get props => [current];
}
