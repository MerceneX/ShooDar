import 'package:flutter/material.dart';
import 'package:shoodar/core/ui/themes/themes.dart';
import 'package:shoodar/features/main_menu/presentation/pages/routes/routes_generator.dart';
import 'package:shoodar/features/radar/presentation/pages/map_page.dart';
import 'injection_container.dart' as di;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
NotificationAppLaunchDetails notificationAppLaunchDetails;
final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  var initializationSettingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
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
      home: MapPage(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

Future onDidReceiveLocalNotification(
    int id, String title, String body, String payload) async {}
