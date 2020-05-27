import 'package:equatable/equatable.dart';

abstract class MainMenuEvent extends Equatable {
  const MainMenuEvent();
}

class UnlockEvent extends MainMenuEvent {
  UnlockEvent();

  @override
  List<Object> get props => [];
}