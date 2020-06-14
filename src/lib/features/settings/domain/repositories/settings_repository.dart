abstract class SettingsRepository {
  Future<void> setRadarAlertDistance(int meters);
  Future<int> getRadarAlertDistance();
}
