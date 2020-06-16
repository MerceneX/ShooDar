abstract class SettingsRepository {
  Future<void> setRadarAlertDistance(int meters);
  Future<int> getRadarAlertDistance();

  Future<void> setCheckRadarPeriode(int second);
  Future<int> getCheckRadarPeriode();

  Future<void> setSoundNotification(bool onOff);
  Future<bool> getSoundNotification();

  Future<void> setAskToAddRadar(bool onOff);
  Future<bool> getAskToAddRadar();

  Future<void> setNotification(bool onOff);
  Future<bool> getNotification();
}
