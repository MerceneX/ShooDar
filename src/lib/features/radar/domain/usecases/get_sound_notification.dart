
import 'package:shoodar/core/usecases/usecase.dart';
import 'package:shoodar/features/radar/domain/repositories/radar_repository.dart';

class GetSoundNotificationRadar implements UseCase<void, NoParams> {
  final RadarRepository repository;

  GetSoundNotificationRadar(this.repository);

  @override
  Future<bool> call(NoParams params) async {
    return await repository.getSoundNotification();
  }
}