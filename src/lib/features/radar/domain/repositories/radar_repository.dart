import 'package:shoodar/features/user/domain/entities/user_location.dart';

import '../entitites/radar.dart';

abstract class RadarRepository {
  Future<List<Radar>> getAllRadars();
  void addRadarOnCurrentLocation();
  Future<void> deleteRadar(String id);
  Future<bool> isRadarClose(UserLocation userLocation);
  Future<bool> isUserLoggedInRadar();
  Future<List<Radar>> getRadarsById();
  Future<Radar> getCloseRadarIfExists(UserLocation userLocation);
  void updateRadar(Radar radar);
}
