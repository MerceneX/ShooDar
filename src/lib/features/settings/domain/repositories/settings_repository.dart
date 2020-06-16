abstract class SettingsRepository {
  Future<void> setRadarAlertDistance(int meters);
  Future<int> getRadarAlertDistance();

  Future<void> setCheckRadarPeriode(int second);
  Future<int> getCheckRadarPeriode();
}
