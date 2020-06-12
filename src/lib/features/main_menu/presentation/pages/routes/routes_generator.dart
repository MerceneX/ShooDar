import 'package:flutter/material.dart';
import 'package:shoodar/features/main_menu/presentation/pages/log_out_page.dart';
import 'package:shoodar/features/main_menu/presentation/pages/main_menu_page.dart';
import 'package:shoodar/features/radar/presentation/pages/advanced_mode_page.dart';
import 'package:shoodar/features/radar/presentation/pages/map_page.dart';
import 'package:shoodar/features/user/presentation/pages/login_user.dart';
import 'package:shoodar/features/user/presentation/pages/register_user.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MapPage());
      case '/menu':
        return MaterialPageRoute(builder: (_) => MainMenuPage());
      case '/map':
        return MaterialPageRoute(builder: (_) => MapPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case '/logout':
        return MaterialPageRoute(builder: (_) => LogOutPage());
      case '/advanced':
        return MaterialPageRoute(builder: (_) => AdvancedModePage());
      case '/settings':
        return MaterialPageRoute(builder: (_) => MainMenuPage());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
