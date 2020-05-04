import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoodar/features/radar/domain/usecases/get_all_radars.dart';
import 'package:shoodar/features/user/data/datasources/services/location_service.dart';
import 'package:shoodar/features/user/domain/entities/user_location.dart';
import 'package:shoodar/features/user/domain/usecases/get_user_location.dart';
import './bloc.dart';

import '../../domain/usecases/add_radar.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:meta/meta.dart';
import 'radar_event.dart';

class RadarBloc extends Bloc<RadarEvent, RadarState> {
  final AddRadar addRadar;
  final GetAllRadars getRadars;
  final GetUserLocation getUserLocation;

  RadarBloc({
    @required AddRadar add,
    @required GetAllRadars getRadars,
    @required GetUserLocation getUserLocation
    })
  :  assert(add!= null),
     assert(getRadars != null),
     assert(getUserLocation != null),
        addRadar = add,
        getRadars = getRadars,
        getUserLocation = getUserLocation;

  @override
  RadarState get initialState => InitialRadarState();

  @override
  Stream<RadarState> mapEventToState(
    RadarEvent event,
  ) async* {
    if(event is AddRadarEvent) {
      addRadar(NoParams());
    } else if(event is LoadMapEvent) {
      Completer<GoogleMapController> controller = Completer();

      Set<Marker> markers = await getRadars(NoParams());

      UserLocation userLocation = await getUserLocation(NoParams());

      LatLng target = LatLng(46.056946,  14.505751);

      if(userLocation != null) {
        target = LatLng(userLocation.latitude, userLocation.longitude);
      }

      CameraPosition initialCameraPosition = CameraPosition(
              zoom: 16,
              target: target,
              tilt: 18,
              bearing: 30
      );

      yield* _loadedState(markers, userLocation, controller, initialCameraPosition);
      
    } else if(event is LocationChangedEvent) {
        // UserLocation userLocation = LocationService().getCurrentLocation;
        //  if(userLocation != null) {
        //    _updatePinOnMap(userLocation, event.controller);
        //   // _loadedState(event.markers, userLocation, event.controller);
        //  }

    }
  }
}

Stream<RadarState> _loadedState(
     Set<Marker> radars, location, controller, initialCameraPosition
  ) async* {
    yield Loaded(radars, location, controller, initialCameraPosition);
  }


