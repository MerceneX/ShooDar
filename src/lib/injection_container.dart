import 'package:get_it/get_it.dart';
import 'features/radar/presentation/bloc/radar_bloc.dart';
import 'features/radar/domain/usecases/add_radar.dart';
import 'features/radar/domain/repositories/radar_repository.dart';
import 'features/radar/data/repositories/radar_repository_impl.dart';
import 'features/radar/data/datasources/radar_data_source.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(
    () => RadarBloc(
      add: sl()
    )
  );
  
  // Use cases
  sl.registerLazySingleton(() => AddRadar(sl()));

  // Repository
  sl.registerLazySingleton<RadarRepository>(
    () => RadarRepositoryImpl(
      radarDataSource: sl()
    ),
  );
  // Data sources
  sl.registerLazySingleton<RadarDataSource>(
  () => RadarDataSourceImpl(),
  );

  //! Core

  //! External
}
