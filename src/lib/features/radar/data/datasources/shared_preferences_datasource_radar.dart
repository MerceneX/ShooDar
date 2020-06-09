import 'package:shared_preferences/shared_preferences.dart';

abstract class RadarSharedPreferencesDataSource {
  Future<String> getUid();
}

class RadarSharedPreferencesDataSourceImpl implements RadarSharedPreferencesDataSource {

  @override
  Future<String> getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid');
  }
}