
import 'package:shoodar/core/usecases/usecase.dart';
import 'package:shoodar/features/radar/domain/repositories/radar_repository.dart';

class GetAskToAddRadarRadar implements UseCase<void, NoParams> {
  final RadarRepository repository;

  GetAskToAddRadarRadar(this.repository);

  @override
  Future<bool> call(NoParams params) async {
    return await repository.getAskToAddRadar();
  }
}