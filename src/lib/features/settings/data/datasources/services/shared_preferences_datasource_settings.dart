import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsSharedPreferencesDataSource {
  Future<String> getRadarAlertDistance();
  void setRadarAlertDistance(int meters);
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
}