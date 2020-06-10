import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoodar/features/radar/domain/entitites/radar.dart';
import 'package:shoodar/features/user/domain/entities/user_location.dart';

abstract class RadarState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialRadarState extends RadarState {}

 class Loading extends RadarState {}

class Loaded extends RadarState {
  final Set<Marker> markers;
  final UserLocation location;
  final Completer<GoogleMapController> controller;
  final CameraPosition initialCameraPosition;
  final bool isUserLoggedIn;
  final List<Radar> radars;

  Loaded(this.markers, this.location, this.controller, this.initialCameraPosition, this.isUserLoggedIn, this.radars);

  @override
  List<Object> get props => [markers, location, controller, isUserLoggedIn];
}

class RadarIsClose extends RadarState {
  final Set<Marker> radars;
  final UserLocation location;
  final Completer<GoogleMapController> controller;
  final CameraPosition initialCameraPosition;

  RadarIsClose(this.radars, this.location, this.controller, this.initialCameraPosition);

}



