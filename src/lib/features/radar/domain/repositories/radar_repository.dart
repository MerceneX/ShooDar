import '../entitites/radar.dart';

abstract class RadarRepository {
  Future<List<Radar>> getAllRadars();
  void addRadarOnCurrentLocation();
  Future<void> deleteRadar(String id);
}
