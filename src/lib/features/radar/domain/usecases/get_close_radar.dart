
import 'package:equatable/equatable.dart';
import 'package:shoodar/features/radar/domain/entitites/radar.dart';
import 'package:shoodar/features/user/domain/entities/user_location.dart';

import '../../domain/repositories/radar_repository.dart';
import '../../../../core/usecases/usecase.dart';

class GetCloseRadar implements UseCase<void, CloseRadarParams> {
  final RadarRepository radarRepository;

  GetCloseRadar(this.radarRepository);

  @override
  Future<Radar> call(CloseRadarParams params) async {
    return radarRepository.getCloseRadarIfExists(params.userLocation);
  }
}

  class CloseRadarParams extends Equatable {
    final UserLocation userLocation;

    CloseRadarParams({this.userLocation});

    @override
    List<Object> get props => [userLocation];
}

