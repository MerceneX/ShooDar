import 'package:meta/meta.dart';
import 'package:shoodar/features/main_menu/data/datasources/services/shared_preferences_datasource_main_menu.dart';
import 'package:shoodar/features/main_menu/domain/repositories/main_menu_repository.dart';


class MainMenuRepositoryImpl implements MainMenuRepository {
  final MainMenuSharedPreferencesDataSource mainMenusharedPreferencesDataSource;

  MainMenuRepositoryImpl({
    @required this.mainMenusharedPreferencesDataSource,
  });

  @override
  Future<bool> isUserLoggedIn() async {
    var uid = await mainMenusharedPreferencesDataSource.getUid();
    if(uid.toString() == "null") return false;
    else return true;
  }

  @override
  Future<void> logoutUser() async {
    mainMenusharedPreferencesDataSource.setUidToNull();
  }
}