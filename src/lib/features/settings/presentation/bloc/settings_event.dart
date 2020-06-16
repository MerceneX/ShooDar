import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class RefreshEvent extends SettingsEvent {
  RefreshEvent();

  @override
  List<Object> get props => [];
}

class SaveEvent extends SettingsEvent {
  final String distance;
  final String periode;
  final bool soundNotification;
  final bool askToAddRadar;
  final bool notification;

  SaveEvent(this.distance, this.periode, this.soundNotification, this.askToAddRadar, this.notification);

  @override
  List<Object> get props => [distance, periode, soundNotification, askToAddRadar, notification];
}