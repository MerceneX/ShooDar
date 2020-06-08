import 'package:flutter/material.dart';
import 'package:shoodar/core/ui/themes/themes.dart';
import 'injection_container.dart' as di;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import './features/main_menu/presentation/pages/main_menu_page.dart';
import 'package:rxdart/subjects.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
NotificationAppLaunchDetails notificationAppLaunchDetails;
final BehaviorSubject<String> selectNotificationSubject = BehaviorSubject<String>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  var initializationSettingsIOS = IOSInitializationSettings(onDidReceiveLocalNotification:onDidReceiveLocalNotification);
  var initializationSettings = InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    selectNotificationSubject.add(payload);
  });
  
  runApp(ShooDar());
}

class ShooDar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShooDar',
      theme: lightTheme(),
      home: MainMenuPage(),
    );
  }
}

Future onDidReceiveLocalNotification(int id, String title, String body, String payload) async {}