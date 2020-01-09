import 'package:flutter/material.dart';
import 'injection_container.dart' as di;

import './features/main_menu/presentation/pages/main_menu_page.dart';

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
        primaryColor: Colors.orange,
        accentColor: Colors.blue,
      ),
      home: MainMenuPage(),
    );
  }
}
