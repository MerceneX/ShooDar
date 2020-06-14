
import 'package:shoodar/core/usecases/usecase.dart';
import 'package:shoodar/features/settings/domain/repositories/settings_repository.dart';

class GetRadarAlertDistance implements UseCase<void, NoParams> {
  final SettingsRepository repository;

  GetRadarAlertDistance(this.repository);

  @override
  Future<int> call(NoParams params) async {
    return await repository.getRadarAlertDistance();
  }
}