import 'package:shoodar/core/usecases/usecase.dart';
import 'package:shoodar/features/settings/domain/repositories/settings_repository.dart';
import 'package:shoodar/features/settings/domain/usecases/set_sound_notification.dart';

class SetAskToAddRadar implements UseCase<void, BoolParams> {
  final SettingsRepository repository;

  SetAskToAddRadar(this.repository);

  @override
  Future<void> call(BoolParams params) async {
    return await repository.setAskToAddRadar(params.onOff);
  }
}