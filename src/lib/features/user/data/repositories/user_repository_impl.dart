import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:shoodar/core/error/failure.dart';
import 'package:shoodar/core/error/exception.dart';
import 'package:shoodar/core/network/network_info.dart';
import 'package:shoodar/features/user/data/datasources/services/auth_remote_datasource.dart';
import 'package:shoodar/features/user/data/datasources/services/location_service.dart';
import 'package:shoodar/features/user/data/datasources/services/shared_preferences_datasource.dart';
import 'package:shoodar/features/user/domain/entities/user_location.dart';
import 'package:shoodar/features/user/domain/repositories/user_repository.dart';


class UserRepositoryImpl implements UserRepository {
  final LocationService locationService;
  final AuthRemoteDataSource authRemoteDataSource;
  final SharedPreferencesDataSource sharedPreferencesDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    @required this.locationService,
    @required this.authRemoteDataSource,
    @required this.sharedPreferencesDataSource,
    @required this.networkInfo,
  });

  @override
  Future<UserLocation> getCurrentLocation() async {
    UserLocation _currentLocation = await locationService.getLocation();
    return _currentLocation;
  }

  @override
  Future<Either<Failure, bool>> loginUser(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final loginUser = await authRemoteDataSource.loginUser(email, password);
        sharedPreferencesDataSource.storeUid(loginUser.user.uid.toString());
        return Right(true);
      } 
      on LoginException catch(e) {
        return Left(LoginFailure(e.message));
      }
    } 
    else {
      return Left(LoginFailure("No internet connection"));
    }
  }

  @override
  Future<Either<Failure, bool>> registerUser(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final registerUser = await authRemoteDataSource.registerUser(email, password);
        sharedPreferencesDataSource.storeUid(registerUser.user.uid.toString());
        return Right(true);
      } 
      on RegisterException catch(e) {
        return Left(RegisterFailure(e.message));
      }
    } 
    else {
      return Left(RegisterFailure("No internet connection"));
    }
  }
}