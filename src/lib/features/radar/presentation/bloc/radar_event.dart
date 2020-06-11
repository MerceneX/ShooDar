
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shoodar/features/radar/domain/entitites/radar.dart';

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
  final String id;

  DeleteRadarsEvent(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateRadarEvent extends RadarEvent {
  final Radar radar;

  UpdateRadarEvent(this.radar);

  @override
  List<Object> get props => [radar];
}

class LocationChangedEvent extends RadarEvent {
  final BuildContext context;
  LocationChangedEvent(this.context);

  @override
  List<Object> get props => [context];
}
