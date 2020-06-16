import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitState extends SettingsState {
  final String radarAlertDistance;
  final String checkRadarPeriode;

  InitState({this.radarAlertDistance, this.checkRadarPeriode});
  List<Object> get props => [radarAlertDistance, checkRadarPeriode];
}

class ErrorState extends SettingsState {
  final String message;

  ErrorState({this.message});
  List<Object> get props => [message];
}