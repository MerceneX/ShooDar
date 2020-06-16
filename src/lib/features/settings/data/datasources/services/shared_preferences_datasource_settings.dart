import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsSharedPreferencesDataSource {
  Future<String> getRadarAlertDistance();
  void setRadarAlertDistance(int meters);

  Future<String> getCheckRadarPeriode();
  void setCheckRadarPeriode(int seconds);
}

class SettingsSharedPreferencesDataSourceImpl implements SettingsSharedPreferencesDataSource {

  @override
  Future<String> getRadarAlertDistance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('radarAlertDistance');
  }

  @override
  void setRadarAlertDistance(int meters) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('radarAlertDistance', meters.toString());  
  }

  @override
  Future<String> getCheckRadarPeriode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('checkRadarPeriode');
  }

  @override
  void setCheckRadarPeriode(int seconds) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('checkRadarPeriode', seconds.toString());  
  }
}