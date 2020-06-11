
import 'package:equatable/equatable.dart';
import 'package:shoodar/features/radar/domain/entitites/radar.dart';

import '../../domain/repositories/radar_repository.dart';
import '../../../../core/usecases/usecase.dart';

class UpdateRadar implements UseCase<void, UpdateRadarParams> {
  final RadarRepository radarRepository;

  UpdateRadar(this.radarRepository);

  @override
  Future<void> call(UpdateRadarParams params) async {
    radarRepository.updateRadar(params.radar);
  }
}

class UpdateRadarParams extends Equatable {
  final Radar radar;

  UpdateRadarParams({this.radar});

  @override
  List<Object> get props => [radar];
}
