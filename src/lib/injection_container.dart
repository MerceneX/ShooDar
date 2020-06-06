import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shoodar/features/radar/domain/usecases/check_for_radars_in_presence.dart';
import 'core/network/network_info.dart';
import 'features/main_menu/presentation/bloc/main_menu_bloc.dart';
import 'features/radar/presentation/bloc/radar_bloc.dart';
import 'features/radar/domain/usecases/add_radar.dart';
import 'features/radar/domain/usecases/get_all_radars.dart';
import 'features/radar/domain/repositories/radar_repository.dart';
import 'features/radar/data/repositories/radar_repository_impl.dart';
import 'features/radar/data/datasources/radar_data_source.dart';
import 'features/user/data/datasources/services/auth_remote_datasource.dart';
import 'features/user/data/datasources/services/location_service.dart';
import 'features/user/data/repositories/user_repository_impl.dart';
import 'features/user/domain/repositories/user_repository.dart';
import 'features/user/domain/usecases/get_user_location.dart';
import 'features/user/domain/usecases/login_user.dart';
import 'features/user/domain/usecases/register_user.dart';
import 'features/user/presentation/bloc/user_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(
    () => RadarBloc(
      add: sl(),
      getRadars: sl(),
      getUserLocation: sl(),
      checkForRadars: sl()
    )
  );
  
  sl.registerFactory(
    () => UserBloc(
      login: sl(),
      register: sl()
    )
  );

  sl.registerFactory(
    () => MainMenuBloc()
  );

  // Use cases
  sl.registerLazySingleton(() => AddRadar(sl()));
  sl.registerLazySingleton(() => GetAllRadars(sl()));
  sl.registerLazySingleton(() => GetUserLocation(sl()));
  sl.registerLazySingleton(() => CheckForRadarsInPresence(sl()));
  
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => LoginUser(sl()));

  // Repository
  sl.registerLazySingleton<RadarRepository>(
    () => RadarRepositoryImpl(
      radarDataSource: sl()
    ),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      locationService: sl(),
      authRemoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<RadarDataSource>(
  () => RadarDataSourceImpl(),
  );

  sl.registerLazySingleton<LocationService>(
  () => LocationService(),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
  () => AuthRemoteDataSourceImpl(),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  
  //! External
  sl.registerLazySingleton(() => DataConnectionChecker());
}