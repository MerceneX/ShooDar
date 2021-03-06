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
  Future<int> getRadarAlertDistance();
  Future<void> setRadarAlertDistance(int meters);
  Future<int> getCheckRadarPeriode();
  Future<void> setCheckRadarPeriode(int seconds);
  Future<bool> getSoundNotification();
  Future<void> setSoundNotification(bool onOff);
  Future<bool> getAskToAddRadar();
  Future<void> setAskToAddRadar(bool onOff);
  Future<bool> getShowNotification();
  Future<void> setShowNotification(bool onOff);
}
