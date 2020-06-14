import 'package:latlong/latlong.dart';
import 'package:meta/meta.dart';
import 'package:shoodar/features/radar/data/datasources/shared_preferences_datasource_radar.dart';
import 'package:shoodar/features/radar/domain/entitites/radar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shoodar/features/user/domain/entities/user_location.dart';

import '../../domain/repositories/radar_repository.dart';
import '../datasources/radar_data_source.dart';

class RadarRepositoryImpl implements RadarRepository {
  final RadarDataSource radarDataSource;
  final RadarSharedPreferencesDataSource radarSharedPreferencesDataSource;
  static List<String> seenRadars = new List();
  static List<String> promptedRadars = new List();

  RadarRepositoryImpl({
    @required this.radarDataSource,
    @required this.radarSharedPreferencesDataSource,
  });

  @override
  Future<void> addRadarOnCurrentLocation() async {
    Position coordinates = await _getCurrentLocation();
    UserLocation userLocation = UserLocation(
        latitude: coordinates.latitude, longitude: coordinates.longitude);

    bool close = await isRadarClose(userLocation, isNew:true);

    if (!close) {
      Radar radar = new Radar(
          timeCreated: DateTime.now(),
          latitude: coordinates.latitude,
          longitude: coordinates.longitude);

      var uid = await radarSharedPreferencesDataSource.getUid();

      radarDataSource.addRadar(radar, uid);
    }
  }

  @override
  Future<List<Radar>> getAllRadars() async {
    List<Radar> all = await radarDataSource.getAllRadars();
    all = _checkForDelete(all);
    return all;
  }

  @override
  Future<void> deleteRadar(String id) async {
    radarDataSource.deleteRadar(id);
  }

  Future<Position> _getCurrentLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    if (position == null) {
      position = await Geolocator()
          .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    }

    return position;
  }

  List<Radar> _checkForDelete(List<Radar> radars) {
    List<String> listToRemove = [];
    for (int i = 0; i < radars.length; i++) {
      Radar radar = radars.elementAt(i);
      DateTime now = DateTime.now();
      Duration difference = now.difference(radar.timeCreated);

      if (difference.inHours > 4) {
        radar.isActive = false;
        radarDataSource.updateRadar(radar);
        listToRemove.add(radar.id);
      } else if (!radar.isActive) {
        listToRemove.add(radar.id);
      }
    }

    listToRemove.forEach((element) => radars.removeWhere((radar) => radar.id == element ));

    return radars;
  }

  @override
  Future<bool> isRadarClose(UserLocation userLocation, {bool isNew = false}) async {
    List<Radar> radars = await getAllRadars();
    bool close = false;
    radars.forEach((Radar radar) {
      Distance distance = new Distance();
      final double meters = distance.as(
          LengthUnit.Meter,
          new LatLng(userLocation.latitude, userLocation.longitude),
          new LatLng(radar.latitude, radar.longitude));

      if (meters < 200 && (isNew || !RadarRepositoryImpl.seenRadars.contains(radar.id))) {
        close = true;
        RadarRepositoryImpl.seenRadars.add(radar.id);
      }
    });
    return close;
  }

  @override
  Future<bool> isUserLoggedInRadar() async {
   var uid = await radarSharedPreferencesDataSource.getUid();
    if(uid.toString() == "null") return false;
    else return true;
  }

  @override
  Future<List<Radar>> getRadarsById() async{
    String id = await radarSharedPreferencesDataSource.getUid();
    List<Radar> radars = await radarDataSource.getRadarsById(id);
    return radars;
  }

  @override
  Future<Radar> getCloseRadarIfExists(UserLocation userLocation,{bool isNew = false}) async {
    List<Radar> radars = await getAllRadars();
    Radar foundRadar;
    radars.forEach((Radar radar) async {
      Distance distance = new Distance();
      final double meters = distance.as(
          LengthUnit.Meter,
          new LatLng(userLocation.latitude, userLocation.longitude),
          new LatLng(radar.latitude, radar.longitude));

      int radarAlertDistance = await getRadarAlertDistance();
      if (meters < radarAlertDistance && !RadarRepositoryImpl.promptedRadars.contains(radar.id)) {
        foundRadar = radar;
        RadarRepositoryImpl.promptedRadars.add(radar.id);
      }
    });
    return foundRadar;
  }

  @override
  void updateRadar(Radar radar) {
    radarDataSource.updateRadar(radar);
  }

  @override
  Future<void> setRadarAlertDistance(int meters) async {
    radarSharedPreferencesDataSource.setRadarAlertDistance(meters);
  }
  
  @override
  Future<int> getRadarAlertDistance() async {
    var distance = await radarSharedPreferencesDataSource.getRadarAlertDistance();
    if(distance == null){
      setRadarAlertDistance(200);
      return(200);
    }
    else{
      return int.parse(distance);
    }
  }
}
