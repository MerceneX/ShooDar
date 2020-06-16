
import 'package:shoodar/core/usecases/usecase.dart';
import 'package:shoodar/features/radar/domain/repositories/radar_repository.dart';

class GetCheckRadarPeriodeRadar implements UseCase<void, NoParams> {
  final RadarRepository repository;

  GetCheckRadarPeriodeRadar(this.repository);

  @override
  Future<int> call(NoParams params) async {
    return await repository.getCheckRadarPeriode();
  }
}