import 'package:shoodar/features/user/domain/entities/user_location.dart';

import '../entitites/radar.dart';

abstract class RadarRepository {
  Future<List<Radar>> getAllRadars();
  void addRadarOnCurrentLocation();
  Future<void> deleteRadar(String id);
  Future<bool> isRadarClose(UserLocation userLocation);
}
