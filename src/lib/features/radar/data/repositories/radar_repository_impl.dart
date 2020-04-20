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
    radarDataSource.getAllRadars();
    Position coordinates = await _getCurrentLocation();
    
    Radar radar = new Radar(
      timeCreated: DateTime.now(), 
      latitude: coordinates.latitude, 
      longitude: coordinates.longitude);
    
    radarDataSource.addRadar(radar);
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

  
}