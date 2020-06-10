import 'package:equatable/equatable.dart';

abstract class MainMenuEvent extends Equatable {
  const MainMenuEvent();
}

class LogOutEvent extends MainMenuEvent {
  LogOutEvent();

  @override
  List<Object> get props => [];
}

class RefreshEvent extends MainMenuEvent {
  RefreshEvent();

  @override
  List<Object> get props => [];
}

class ChangePageEvent extends MainMenuEvent {
  final int page;

  ChangePageEvent({this.page});

  @override
  List<Object> get props => [page];
}