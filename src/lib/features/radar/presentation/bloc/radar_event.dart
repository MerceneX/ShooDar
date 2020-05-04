import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

class LocationChangedEvent extends RadarEvent {
  final Completer<GoogleMapController> controller; 
  final Set<Marker> markers;

  LocationChangedEvent(this.markers, this.controller);

  @override
  List<Object> get props => [controller];
}
