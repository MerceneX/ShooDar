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

  SaveEvent(this.distance);

  @override
  List<Object> get props => [];
}