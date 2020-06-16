import 'package:shared_preferences/shared_preferences.dart';

abstract class RadarSharedPreferencesDataSource {
  Future<String> getUid();

  Future<String> getRadarAlertDistance();
  void setRadarAlertDistance(int meters);

  Future<String> getCheckRadarPeriode();
  void setCheckRadarPeriode(int seconds);

  Future<bool> getSoundNotification();
  void setSoundNotification(bool onOff);

  Future<bool> getAskToAddRadar();
  void setAskToAddRadar(bool onOff);

  Future<bool> getShowNotification();
  void setShowNotification(bool onOff);
}

class RadarSharedPreferencesDataSourceImpl implements RadarSharedPreferencesDataSource {

  @override
  Future<String> getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid');
  }

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
  void setSoundNotification(bool onOff) async {print(onOff);
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
  Future<bool> getShowNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('notification');
  }

  @override
  void setShowNotification(bool onOff) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notification', onOff);  
  }
}