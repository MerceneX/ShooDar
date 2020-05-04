import 'package:meta/meta.dart';
import 'package:shoodar/features/user/data/datasources/services/location_service.dart';
import 'package:shoodar/features/user/domain/entities/user_location.dart';
import 'package:shoodar/features/user/domain/repositories/user_repository.dart';


class UserRepositoryImpl implements UserRepository {
  final LocationService locationService;

  UserRepositoryImpl({
    @required this.locationService,
  });

  @override
  Future<UserLocation> getCurrentLocation() async {
    UserLocation _currentLocation = await locationService.getLocation();
    return _currentLocation;
  }


}