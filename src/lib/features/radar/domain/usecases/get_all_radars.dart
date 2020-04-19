
import 'package:shoodar/features/radar/domain/entitites/radar.dart';

import '../../domain/repositories/radar_repository.dart';
import '../../../../core/usecases/usecase.dart';

class GetAllRadars implements UseCase<void, NoParams> {
  final RadarRepository radarRepository;

  GetAllRadars(this.radarRepository);

  @override
  Future<List<Radar>> call(NoParams params) async {
    return radarRepository.getAllRadars();
  }
}
