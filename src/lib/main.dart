import 'package:flutter/material.dart';
import 'package:shoodar/core/ui/themes/themes.dart';
import 'injection_container.dart' as di;

import './features/main_menu/presentation/pages/main_menu_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
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
