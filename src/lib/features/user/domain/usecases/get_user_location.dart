
import 'package:geolocator/geolocator.dart';
import 'package:shoodar/features/user/domain/entities/user_location.dart';

import '../../domain/repositories/user_repository.dart';
import '../../../../core/usecases/usecase.dart';

class GetUserLocation implements UseCase<void, NoParams> {
  final UserRepository userRepository;

  GetUserLocation(this.userRepository);

  @override
  Future<UserLocation> call(NoParams params) async {
    return userRepository.getCurrentLocation();
  }
}