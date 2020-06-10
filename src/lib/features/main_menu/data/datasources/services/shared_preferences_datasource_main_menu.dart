import 'package:shared_preferences/shared_preferences.dart';

abstract class MainMenuSharedPreferencesDataSource {
  Future<String> getUid();
  void setUidToNull();
}

class MainMenuSharedPreferencesDataSourceImpl implements MainMenuSharedPreferencesDataSource {

  @override
  Future<String> getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid');
  }

  @override
  void setUidToNull() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', "null");  
  }
}