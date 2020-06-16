import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoodar/features/radar/domain/entitites/radar.dart';
import 'package:shoodar/features/radar/domain/usecases/check_for_radars_in_presence.dart';
import 'package:shoodar/features/radar/domain/usecases/delete_radar.dart';
import 'package:shoodar/features/radar/domain/usecases/get_check_radar_periode_radar.dart';
import 'package:shoodar/features/radar/domain/usecases/get_close_radar.dart';
import 'package:shoodar/features/radar/domain/usecases/get_radars.dart';
import 'package:shoodar/features/radar/domain/usecases/get_markers.dart';
import 'package:shoodar/features/radar/domain/usecases/get_radars_by_id.dart';
import 'package:shoodar/features/radar/domain/usecases/is_user_logged_in_radar.dart';
import 'package:shoodar/features/radar/domain/usecases/update_radar.dart';
import 'package:shoodar/features/radar/presentation/widgets/is_radar_still_there_dialog.dart';
import 'package:shoodar/features/radar/presentation/widgets/notification_dialog.dart';
import 'package:shoodar/features/user/domain/entities/user_location.dart';
import 'package:shoodar/features/user/domain/usecases/get_user_location.dart';
import '../../../../main.dart';
import './bloc.dart';

import '../../domain/usecases/add_radar.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/appState/appState.dart';
import 'radar_event.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class RadarBloc extends Bloc<RadarEvent, RadarState> {
  final AddRadar addRadar;
  final GetMarkers getMarkers;
  final GetRadars getRadars;
  final GetUserLocation getUserLocation;
  final CheckForRadarsInPresence checkForRadars;
  final GetCloseRadar getCloseRadar;
  final IsUserLoggedInRadar isUserLoggedInRadar;
  final DeleteRadar deleteRadar;
  final GetRadarsById getRadarsById;
  final UpdateRadar updateRadar;
  final AppState appState = new AppState();
  final GetCheckRadarPeriodeRadar radarPeriode;

  RadarBloc({
    @required AddRadar add,
    @required GetMarkers getMarkers,
    @required GetRadars getRadars,
    @required GetUserLocation getUserLocation,
    @required CheckForRadarsInPresence checkForRadars,
    @required IsUserLoggedInRadar isUserLoggedInRadar,
    @required DeleteRadar deleteRadar,
    @required GetRadarsById getRadarsById,
    @required GetCloseRadar getCloseRadar,
    @required UpdateRadar updateRadar,
    @required GetCheckRadarPeriodeRadar radarPeriode,
  })  : assert(add != null),
        assert(getMarkers != null),
        assert(getUserLocation != null),
        assert(getRadars != null),
        assert(checkForRadars != null),
        assert(isUserLoggedInRadar != null),
        assert(deleteRadar != null),
        assert(getRadarsById != null),
        assert(getCloseRadar != null),
        assert(updateRadar != null),
        assert(radarPeriode != null),
        addRadar = add,
        getMarkers = getMarkers,
        getUserLocation = getUserLocation,
        getRadars = getRadars,
        checkForRadars = checkForRadars,
        isUserLoggedInRadar = isUserLoggedInRadar,
        deleteRadar = deleteRadar,
        getCloseRadar = getCloseRadar,
        updateRadar = updateRadar,
        getRadarsById = getRadarsById,
        radarPeriode = radarPeriode;

  @override
  RadarState get initialState => InitialRadarState();

  @override
  Stream<RadarState> mapEventToState(
    RadarEvent event,
  ) async* {
    if (event is AddRadarEvent) {
      addRadar(NoParams());
    } else if (event is GetRadarsEvent) {
      bool isLoggedIn = await isUserLoggedInRadar(NoParams());

      List<Radar> radars;
      if(isLoggedIn) {
        radars = await getRadarsById(NoParams());
      } else {
        radars = [];
      }
      int periode = await radarPeriode(NoParams());
      yield* _loadedState(null, null, null, null, isLoggedIn, periode, radars: radars);
    } else if (event is DeleteRadarsEvent) {
      List<Radar> radars = await getRadars(NoParams());
      bool isLoggedIn = await isUserLoggedInRadar(NoParams());

      await deleteRadar(DeleteRadarParams(radarId: event.id));
      int periode = await radarPeriode(NoParams());

      yield* _loadedState(null, null, null, null, isLoggedIn, periode, radars: radars);
    } else if (event is UpdateRadarEvent) {   
        updateRadar(UpdateRadarParams(radar: event.radar));
      }else if (event is LoadMapEvent) {
      Completer<GoogleMapController> controller = Completer();

      Set<Marker> markers = await getMarkers(NoParams());

      UserLocation userLocation = await getUserLocation(NoParams());

      LatLng target = LatLng(46.056946, 14.505751);

      if (userLocation != null) {
        target = LatLng(userLocation.latitude, userLocation.longitude);
      }

      CameraPosition initialCameraPosition =
          CameraPosition(zoom: 16, target: target, tilt: 18, bearing: 30);

      bool isLoggedIn = await isUserLoggedInRadar(NoParams());
      int periode = await radarPeriode(NoParams());
      yield* _loadedState(
          markers, userLocation, controller, initialCameraPosition, isLoggedIn, periode);
    } else if (event is LocationChangedEvent) {
      Completer<GoogleMapController> controller = Completer();

      Set<Marker> markers = await getMarkers(NoParams());

      UserLocation loc = await getUserLocation(NoParams());

      LatLng target = LatLng(46.056946, 14.505751);

      if (loc != null) {
        target = LatLng(loc.latitude, loc.longitude);
      } 

      CameraPosition initialCameraPosition =
          CameraPosition(zoom: 16, target: target, tilt: 18, bearing: 30);

      bool isLoggedIn = await isUserLoggedInRadar(NoParams());

      bool radarClose = await checkForRadars(Params(userLocation: loc));
      Radar closeRadar = await getCloseRadar(CloseRadarParams(userLocation: loc));

      if (radarClose) {
        
        if (appState.appCurrentState != AppLifecycleState.resumed) {
          await _dispatchNotification();
        }
        playRadarAlertSound();

        _showRadarAlertDialog(event.context);

        Future.delayed(Duration(seconds: 15), () {
             _showRadarExistanceConfirmationDialog(event.context, closeRadar);
          });
        int periode = await radarPeriode(NoParams());
        yield* _loadedState(
            markers, loc, controller, initialCameraPosition, isLoggedIn, periode);
      }
    }
  }

  Stream<RadarState> _loadedState(Set<Marker> markers, location, controller, initialCameraPosition, isLoggedIn, checkRadarPeriode, {List<Radar> radars}) async* {
    yield Loaded(markers, location, controller, initialCameraPosition,
        isLoggedIn, radars, checkRadarPeriode);
  }

  Future<AudioPlayer> playRadarAlertSound() async {
    AudioCache cache = new AudioCache();
    return await cache.play("notificationSound.mp3");
  }

  Future<void> _showRadarAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return RadarAlertDialog();
      },
    );
  }

  Future<void> _showRadarExistanceConfirmationDialog(BuildContext context, Radar radar) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return IsRadarThereDialog(radar: radar);
      },
    );
  }

  Future<void> _dispatchNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel_ID', 'channel name', 'channel description',
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'test ticker');

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0, 'Radar!', 'You are nearby a radar!', platformChannelSpecifics,
        payload: 'test oayload');
  }
}
