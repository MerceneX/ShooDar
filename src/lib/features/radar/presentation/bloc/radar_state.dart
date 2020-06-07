import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoodar/features/user/domain/entities/user_location.dart';

abstract class RadarState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialRadarState extends RadarState {}

 class Loading extends RadarState {}

class Loaded extends RadarState {
  final Set<Marker> radars;
  final UserLocation location;
  final Completer<GoogleMapController> controller;
  final CameraPosition initialCameraPosition;

  Loaded(this.radars, this.location, this.controller, this.initialCameraPosition);

  @override
  List<Object> get props => [radars, location, controller];
}

class RadarIsClose extends RadarState {
  final Set<Marker> radars;
  final UserLocation location;
  final Completer<GoogleMapController> controller;
  final CameraPosition initialCameraPosition;

  RadarIsClose(this.radars, this.location, this.controller, this.initialCameraPosition);

}



