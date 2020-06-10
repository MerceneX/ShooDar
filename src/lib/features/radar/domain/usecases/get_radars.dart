import 'package:shoodar/core/usecases/usecase.dart';
import 'package:shoodar/features/radar/domain/entitites/radar.dart';
import 'package:shoodar/features/radar/domain/repositories/radar_repository.dart';

class GetRadars implements UseCase<void, NoParams> {
  final RadarRepository radarRepository;

  GetRadars(this.radarRepository);

  @override
  Future<List<Radar>> call(NoParams params) async {
    List<Radar> radars = await radarRepository.getAllRadars();
    return radars;
  }
}