import 'package:flutter/widgets.dart';

class AppState extends WidgetsBindingObserver {
  AppLifecycleState appCurrentState = AppLifecycleState.resumed;

  AppState(){
    WidgetsBinding.instance.addObserver(this);
  }

  disp(){
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    appCurrentState = state;
  }
}