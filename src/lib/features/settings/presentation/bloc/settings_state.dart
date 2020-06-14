import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitState extends SettingsState {
  final String radarAlertDistance;

  InitState({this.radarAlertDistance});
  List<Object> get props => [radarAlertDistance];
}

class ErrorState extends SettingsState {
  final String message;

  ErrorState({this.message});
  List<Object> get props => [message];
}