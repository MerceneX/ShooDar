import 'package:equatable/equatable.dart';

abstract class MainMenuEvent extends Equatable {
  const MainMenuEvent();
}

class UnlockEvent extends MainMenuEvent {
  UnlockEvent();

  @override
  List<Object> get props => [];
}

class ChangePageEvent extends MainMenuEvent {
  final int page;

  ChangePageEvent({this.page});

  @override
  List<Object> get props => [page];
}
