import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesDataSource {
  void storeUid(String uid);
}

class SharedPreferencesDataSourceImpl implements SharedPreferencesDataSource {

  @override
  void storeUid(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', uid);
    print(prefs.getString('uid'));
  }
}