
import 'package:shoodar/core/usecases/usecase.dart';
import 'package:shoodar/features/settings/domain/repositories/settings_repository.dart';

class GetNotification implements UseCase<void, NoParams> {
  final SettingsRepository repository;

  GetNotification(this.repository);

  @override
  Future<bool> call(NoParams params) async {
    return await repository.getNotification();
  }
}