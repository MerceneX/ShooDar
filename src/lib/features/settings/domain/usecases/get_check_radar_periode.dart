
import 'package:shoodar/core/usecases/usecase.dart';
import 'package:shoodar/features/settings/domain/repositories/settings_repository.dart';

class GetCheckRadarPeriode implements UseCase<void, NoParams> {
  final SettingsRepository repository;

  GetCheckRadarPeriode(this.repository);

  @override
  Future<int> call(NoParams params) async {
    return await repository.getCheckRadarPeriode();
  }
}