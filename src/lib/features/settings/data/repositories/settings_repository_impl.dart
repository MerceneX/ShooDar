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
}