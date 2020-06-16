
import 'package:shoodar/core/usecases/usecase.dart';
import 'package:shoodar/features/settings/domain/repositories/settings_repository.dart';

class GetSoundNotification implements UseCase<void, NoParams> {
  final SettingsRepository repository;

  GetSoundNotification(this.repository);

  @override
  Future<bool> call(NoParams params) async {
    return await repository.getSoundNotification();
  }
}