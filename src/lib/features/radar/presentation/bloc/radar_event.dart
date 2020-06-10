
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class RadarEvent extends Equatable {
  const RadarEvent();
}

// class Loading extends RadarEvent {
//   @override
//   List<Object> get props => null;
// }

class AddRadarEvent extends RadarEvent {
  AddRadarEvent();

  @override
  List<Object> get props => null;
}

class LoadMapEvent extends RadarEvent {
  LoadMapEvent();

  @override
  List<Object> get props => [];
}

class GetRadarsEvent extends RadarEvent {
  GetRadarsEvent();

  @override
  List<Object> get props => [];
}

class DeleteRadarsEvent extends RadarEvent {
  String id;

  DeleteRadarsEvent(this.id);

  @override
  List<Object> get props => [id];
}

class LocationChangedEvent extends RadarEvent {
  BuildContext context;
  LocationChangedEvent(this.context);

  @override
  List<Object> get props => [context];
}
