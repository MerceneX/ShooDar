import 'package:shoodar/core/usecases/usecase.dart';
import 'package:shoodar/features/radar/domain/entitites/radar.dart';
import 'package:shoodar/features/radar/domain/repositories/radar_repository.dart';

class GetRadarsById implements UseCase<void, NoParams> {
  final RadarRepository radarRepository;

  GetRadarsById(this.radarRepository);

  @override
  Future<List<Radar>> call(NoParams params) async {
    List<Radar> radars = await radarRepository.getRadarsById();
    return radars;
  }
}