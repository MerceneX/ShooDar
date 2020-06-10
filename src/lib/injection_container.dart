import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shoodar/features/main_menu/data/datasources/services/shared_preferences_datasource_main_menu.dart';
import 'package:shoodar/features/main_menu/data/repositories/main_menu_repository_impl.dart';
import 'package:shoodar/features/main_menu/domain/repositories/main_menu_repository.dart';
import 'package:shoodar/features/main_menu/domain/usecases/is_user_logged_in.dart';
import 'package:shoodar/features/radar/data/datasources/shared_preferences_datasource_radar.dart';
import 'package:shoodar/features/radar/domain/usecases/check_for_radars_in_presence.dart';
import 'package:shoodar/features/radar/domain/usecases/is_user_logged_in_radar.dart';
import 'package:shoodar/features/user/data/datasources/services/shared_preferences_datasource.dart';
import 'core/network/network_info.dart';
import 'features/main_menu/domain/usecases/logout_user.dart';
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
      checkForRadars: sl(),
      isUserLoggedInRadar: sl()
    )
  );
  
  sl.registerFactory(
    () => UserBloc(
      login: sl(),
      register: sl()
    )
  );

  sl.registerFactory(
    () => MainMenuBloc(
      isUserLoggedIn: sl(),
      logoutUser: sl()
    )
  );

  // Use cases
  sl.registerLazySingleton(() => AddRadar(sl()));
  sl.registerLazySingleton(() => GetAllRadars(sl()));
  sl.registerLazySingleton(() => GetUserLocation(sl()));
  sl.registerLazySingleton(() => CheckForRadarsInPresence(sl()));
  sl.registerLazySingleton(() => IsUserLoggedInRadar(sl()));
  
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => LoginUser(sl()));

  sl.registerLazySingleton(() => IsUserLoggedIn(sl()));
  sl.registerLazySingleton(() => LogoutUser(sl()));

  // Repository
  sl.registerLazySingleton<RadarRepository>(
    () => RadarRepositoryImpl(
      radarDataSource: sl(),
      radarSharedPreferencesDataSource: sl()
    ),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      locationService: sl(),
      authRemoteDataSource: sl(),
      sharedPreferencesDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<MainMenuRepository>(
    () => MainMenuRepositoryImpl(
      mainMenusharedPreferencesDataSource: sl()
    ),
  );

  // Data sources
  sl.registerLazySingleton<RadarDataSource>(
  () => RadarDataSourceImpl(),
  );

  sl.registerLazySingleton<RadarSharedPreferencesDataSource>(
  () => RadarSharedPreferencesDataSourceImpl(),
  );

  sl.registerLazySingleton<LocationService>(
  () => LocationService(),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
  () => AuthRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<SharedPreferencesDataSource>(
  () => SharedPreferencesDataSourceImpl(),
  );

  sl.registerLazySingleton<MainMenuSharedPreferencesDataSource>(
  () => MainMenuSharedPreferencesDataSourceImpl(),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  
  //! External
  sl.registerLazySingleton(() => DataConnectionChecker());
}