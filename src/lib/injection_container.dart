import 'package:get_it/get_it.dart';
import 'features/radar/presentation/bloc/radar_bloc.dart';
import 'features/radar/domain/usecases/add_radar.dart';
import 'features/radar/domain/usecases/get_all_radars.dart';
import 'features/radar/domain/repositories/radar_repository.dart';
import 'features/radar/data/repositories/radar_repository_impl.dart';
import 'features/radar/data/datasources/radar_data_source.dart';
import 'features/user/data/datasources/services/location_service.dart';
import 'features/user/data/repositories/user_repository_impl.dart';
import 'features/user/domain/repositories/user_repository.dart';
import 'features/user/domain/usecases/get_user_location.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(
    () => RadarBloc(
      add: sl(),
      getRadars: sl(),
      getUserLocation: sl()
    )
  );
  
  // Use cases
  sl.registerLazySingleton(() => AddRadar(sl()));
  sl.registerLazySingleton(() => GetAllRadars(sl()));
  sl.registerLazySingleton(() => GetUserLocation(sl()));

  // Repository
  sl.registerLazySingleton<RadarRepository>(
    () => RadarRepositoryImpl(
      radarDataSource: sl()
    ),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      locationService: sl()
    ),
  );
  // Data sources
  sl.registerLazySingleton<RadarDataSource>(
  () => RadarDataSourceImpl(),
  );

  sl.registerLazySingleton<LocationService>(
  () => LocationService(),
  );

  //! Core

  //! External
}
