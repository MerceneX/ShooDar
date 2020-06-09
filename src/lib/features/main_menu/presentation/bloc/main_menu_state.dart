import 'package:equatable/equatable.dart';

abstract class MainMenuState extends Equatable {
  @override
  List<Object> get props => [];
}

class Unlocked extends MainMenuState {

  Unlocked();
  List<Object> get props => [];
}

class Locked extends MainMenuState {

  Locked();
  List<Object> get props => [];
}

class NavigationState extends MainMenuState {
  final int current;

  NavigationState({this.current});
  List<Object> get props => [current];
}