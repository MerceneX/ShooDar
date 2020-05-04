
import 'package:shoodar/features/user/domain/entities/user_location.dart';

abstract class UserRepository {
  Future<UserLocation> getCurrentLocation();
}
