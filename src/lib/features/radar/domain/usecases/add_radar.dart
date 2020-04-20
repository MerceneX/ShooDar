
import '../../domain/repositories/radar_repository.dart';
import '../../../../core/usecases/usecase.dart';

class AddRadar implements UseCase<void, NoParams> {
  final RadarRepository radarRepository;

  AddRadar(this.radarRepository);

  @override
  Future<void> call(NoParams params) async {
    radarRepository.addRadarOnCurrentLocation();
  }
}
