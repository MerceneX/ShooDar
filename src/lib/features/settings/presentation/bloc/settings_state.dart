import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitState extends SettingsState {
  final String radarAlertDistance;
  final String checkRadarPeriode;
  final bool soundNotification;
  final bool askToAddRadar;
  final bool notification;

  InitState({this.radarAlertDistance, this.checkRadarPeriode, this.soundNotification, this.askToAddRadar, this.notification});
  List<Object> get props => [radarAlertDistance, checkRadarPeriode, soundNotification, askToAddRadar, notification];
}

class ErrorState extends SettingsState {
  final String message;

  ErrorState({this.message});
  List<Object> get props => [message];
}