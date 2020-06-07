import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoodar/features/radar/domain/usecases/check_for_radars_in_presence.dart';
import 'package:shoodar/features/radar/domain/usecases/get_all_radars.dart';
import 'package:shoodar/features/radar/presentation/widgets/notification_dialog.dart';
import 'package:shoodar/features/user/domain/entities/user_location.dart';
import 'package:shoodar/features/user/domain/usecases/get_user_location.dart';
import './bloc.dart';

import '../../domain/usecases/add_radar.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:meta/meta.dart';
import 'radar_event.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class RadarBloc extends Bloc<RadarEvent, RadarState> {
  final AddRadar addRadar;
  final GetAllRadars getRadars;
  final GetUserLocation getUserLocation;
  final CheckForRadarsInPresence checkForRadars;

  RadarBloc({
    @required AddRadar add,
    @required GetAllRadars getRadars,
    @required GetUserLocation getUserLocation,
    @required CheckForRadarsInPresence checkForRadars
    })
  :  assert(add!= null),
     assert(getRadars != null),
     assert(getUserLocation != null),
     assert(checkForRadars != null),
        addRadar = add,
        getRadars = getRadars,
        getUserLocation = getUserLocation,
        checkForRadars = checkForRadars;

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
      Completer<GoogleMapController> controller = Completer();

      Set<Marker> markers = await getRadars(NoParams());

      UserLocation loc = await getUserLocation(NoParams());

      LatLng target = LatLng(46.056946,  14.505751);

      if(loc != null) {
        target = LatLng(loc.latitude, loc.longitude);
      }

      CameraPosition initialCameraPosition = CameraPosition(
              zoom: 16,
              target: target,
              tilt: 18,
              bearing: 30
      );
      
      bool radarClose = await checkForRadars(Params(userLocation: loc));

      if(radarClose) {
         playRadarAlertSound();  
         showRadarAlertDialog(event.context);
         yield* _loadedState(markers, loc, controller, initialCameraPosition);
      }
    }
  }

Stream<RadarState> _loadedState(
     Set<Marker> radars, location, controller, initialCameraPosition
  ) async* {
    yield Loaded(radars, location, controller, initialCameraPosition);
  }

Future<AudioPlayer> playRadarAlertSound() async {
  AudioCache cache = new AudioCache();
  return await cache.play("notificationSound.mp3");
}

Future<void> showRadarAlertDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return RadarAlertDialog();
    },
  );
}

}
