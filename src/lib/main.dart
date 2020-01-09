import 'package:flutter/material.dart';
import 'injection_container.dart' as di;

import './features/main_menu/presentation/pages/main_menu_page.dart';
import './features/add_radar/presentation/pages/simple_mode_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShooDar',
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
        accentColor: Colors.green.shade600,
      ),
      home: MainMenuPage(),
    );
  }
}
