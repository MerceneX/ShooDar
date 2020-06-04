
import 'package:equatable/equatable.dart';
import 'package:shoodar/features/user/domain/entities/user_location.dart';

import '../../domain/repositories/radar_repository.dart';
import '../../../../core/usecases/usecase.dart';

class CheckForRadarsInPresence implements UseCase<void, Params> {
  final RadarRepository radarRepository;

  CheckForRadarsInPresence(this.radarRepository);

  @override
  Future<bool> call(Params params) async {
    return radarRepository.isRadarClose(params.userLocation);
  }
}

  class Params extends Equatable {
    final UserLocation userLocation;

    Params({this.userLocation});

    @override
    List<Object> get props => [userLocation];
}

