import 'package:meta/meta.dart';
import 'package:shoodar/features/settings/data/datasources/services/shared_preferences_datasource_settings.dart';
import 'package:shoodar/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsSharedPreferencesDataSource settingsSharedPreferencesDataSource;

  SettingsRepositoryImpl({
    @required this.settingsSharedPreferencesDataSource,
  });

  @override
  Future<void> setRadarAlertDistance(int meters) async {
    settingsSharedPreferencesDataSource.setRadarAlertDistance(meters);
  }

  @override
  Future<int> getRadarAlertDistance() async {
    var distance = await settingsSharedPreferencesDataSource.getRadarAlertDistance();
    if(distance == null){
      setRadarAlertDistance(200);
      return(200);
    }
    else{
      return int.parse(distance);
    }
  }

  @override
  Future<void> setCheckRadarPeriode(int seconds) async {
    settingsSharedPreferencesDataSource.setCheckRadarPeriode(seconds);
  }

  @override
  Future<int> getCheckRadarPeriode() async {
    var periode = await settingsSharedPreferencesDataSource.getCheckRadarPeriode();
    if(periode == null){
      setCheckRadarPeriode(15);
      return(15);
    }
    else{
      return int.parse(periode);
    }
  }

  @override
  Future<void> setSoundNotification(bool onOff) async {
    settingsSharedPreferencesDataSource.setSoundNotification(onOff);
  }

  @override
  Future<bool> getSoundNotification() async {
    var onOff = await settingsSharedPreferencesDataSource.getSoundNotification();
    if(onOff == null){
      setSoundNotification(true);
      return(true);
    }
    else{
      return onOff;
    }
  }

  @override
  Future<void> setAskToAddRadar(bool onOff) async {
    settingsSharedPreferencesDataSource.setAskToAddRadar(onOff);
  }

  @override
  Future<bool> getAskToAddRadar() async {
    var onOff = await settingsSharedPreferencesDataSource.getAskToAddRadar();
    if(onOff == null){
      setAskToAddRadar(true);
      return(true);
    }
    else{
      return onOff;
    }
  }

  @override
  Future<void> setNotification(bool onOff) async {
    settingsSharedPreferencesDataSource.setNotification(onOff);
  }

  @override
  Future<bool> getNotification() async {
    var onOff = await settingsSharedPreferencesDataSource.getNotification();
    if(onOff == null){
      setNotification(true);
      return(true);
    }
    else{
      return onOff;
    }
  }
}