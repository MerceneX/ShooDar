import '../entitites/radar.dart';

abstract class RadarRepository {
  Radar getAllRadars();
  void addRadarOnCurrentLocation();
}
