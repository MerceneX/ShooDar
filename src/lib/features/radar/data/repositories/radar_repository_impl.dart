import 'package:latlong/latlong.dart';
import 'package:meta/meta.dart';
import 'package:shoodar/features/radar/domain/entitites/radar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shoodar/features/user/domain/entities/user_location.dart';

import '../../domain/repositories/radar_repository.dart';
import '../datasources/radar_data_source.dart';


class RadarRepositoryImpl implements RadarRepository {
  final RadarDataSource radarDataSource;
  static List<String> seenRadars = new List();

  RadarRepositoryImpl({
    @required this.radarDataSource,
  });

  @override
  Future<void> addRadarOnCurrentLocation() async { 
    Position coordinates = await _getCurrentLocation();
    UserLocation userLocation = UserLocation(latitude: coordinates.latitude, longitude: coordinates.longitude);

    bool close = await isRadarClose(userLocation);
    
    if(!close) {
      Radar radar = new Radar(
        timeCreated: DateTime.now(), 
        latitude: coordinates.latitude, 
        longitude: coordinates.longitude);
      
      radarDataSource.addRadar(radar);
    }
  }

  @override
  Future<List<Radar>> getAllRadars() async {
    List<Radar> all = await radarDataSource.getAllRadars();
    return all;
  }

  @override
  Future<void> deleteRadar(String id) async {
    radarDataSource.deleteRadar(id);
  }

  Future<Position> _getCurrentLocation() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    if(position == null) {
      position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    }

    return position;
  }

  @override
  Future<bool> isRadarClose(UserLocation userLocation) async {   
    List<Radar> radars = await getAllRadars();
    bool close = false; 
    radars.forEach((Radar radar) {
      Distance distance = new Distance();
      final double meters = distance.as(LengthUnit.Meter,
        new LatLng(userLocation.latitude, userLocation.longitude),
        new LatLng(radar.latitude, radar.longitude));

      if(meters < 200 && !RadarRepositoryImpl.seenRadars.contains(radar.id)) {
        close = true;
        seenRadars.add(radar.id);     
      }
    });
    return close;
  }  
}