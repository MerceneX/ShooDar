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