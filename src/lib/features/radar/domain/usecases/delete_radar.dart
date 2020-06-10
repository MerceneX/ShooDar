import 'package:equatable/equatable.dart';
import 'package:shoodar/core/usecases/usecase.dart';
import 'package:shoodar/features/radar/domain/entitites/radar.dart';
import 'package:shoodar/features/radar/domain/repositories/radar_repository.dart';

class DeleteRadar implements UseCase<void, DeleteRadarParams> {
  final RadarRepository radarRepository;

  DeleteRadar(this.radarRepository);

  @override
  Future<List<Radar>> call(DeleteRadarParams params) async {
    await radarRepository.deleteRadar(params.radarId);
  }

}
class DeleteRadarParams extends Equatable {
  final String radarId;

  DeleteRadarParams({this.radarId});

  @override
  List<Object> get props => [radarId];
}