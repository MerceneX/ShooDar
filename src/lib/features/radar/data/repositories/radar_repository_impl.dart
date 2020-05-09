import 'package:latlong/latlong.dart';
import 'package:meta/meta.dart';
import 'package:shoodar/features/radar/domain/entitites/radar.dart';
import 'package:geolocator/geolocator.dart';

import '../../domain/repositories/radar_repository.dart';
import '../datasources/radar_data_source.dart';


class RadarRepositoryImpl implements RadarRepository {
  final RadarDataSource radarDataSource;

  RadarRepositoryImpl({
    @required this.radarDataSource,
  });

  @override
  Future<void> addRadarOnCurrentLocation() async { 
    List<Radar> all = await radarDataSource.getAllRadars();
    Position coordinates = await _getCurrentLocation();

    bool add = checkForRadarOnLocation(coordinates, all);
    
    if(add) {
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

    if(position == null)
      position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);

    return position;
  }

  bool checkForRadarOnLocation(Position loc,List<Radar> radars) {
    bool add = true;
    radars.forEach((Radar radar) {
      Distance distance = new Distance();
      final double meters = distance.as(LengthUnit.Meter,
        new LatLng(loc.latitude, loc.longitude),
        new LatLng(radar.latitude, radar.longitude));

      if(meters < 500) {
        add = false;        
      }
    });

    return add;
  }

  
}