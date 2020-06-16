import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsSharedPreferencesDataSource {
  Future<String> getRadarAlertDistance();
  void setRadarAlertDistance(int meters);

  Future<String> getCheckRadarPeriode();
  void setCheckRadarPeriode(int seconds);

  Future<bool> getSoundNotification();
  void setSoundNotification(bool onOff);

  Future<bool> getAskToAddRadar();
  void setAskToAddRadar(bool onOff);

  Future<bool> getNotification();
  void setNotification(bool onOff);
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

  @override
  Future<bool> getSoundNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('soundNotification');
  }

  @override
  void setSoundNotification(bool onOff) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('soundNotification', onOff);  
  }

  @override
  Future<bool> getAskToAddRadar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('askToAddRadar');
  }

  @override
  void setAskToAddRadar(bool onOff) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('askToAddRadar', onOff);  
  }

  @override
  Future<bool> getNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('notification');
  }

  @override
  void setNotification(bool onOff) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notification', onOff);  
  }
}