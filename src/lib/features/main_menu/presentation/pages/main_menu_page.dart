import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/features/main_menu/presentation/bloc/main_menu_bloc.dart';
import 'package:shoodar/features/main_menu/presentation/bloc/main_menu_event.dart';
import 'package:shoodar/features/main_menu/presentation/bloc/main_menu_state.dart';
import 'package:shoodar/features/main_menu/presentation/widgets/display_message.dart';
import 'package:shoodar/features/radar/presentation/pages/simple_mode_page.dart';
import 'package:shoodar/features/radar/presentation/pages/advanced_mode_page.dart';
import 'package:shoodar/features/user/presentation/pages/login_user.dart';
import 'package:shoodar/features/user/presentation/pages/register_user.dart';
import 'package:shoodar/features/radar/presentation/pages/map_page.dart';

import 'package:toast/toast.dart';

import '../../../../injection_container.dart';

class MainMenuPage extends StatelessWidget {
  static bool isLocked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<MainMenuBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<MainMenuBloc>(),
        child: Center(child: buildNavigation(context)));
  }

  Column buildNavigation(BuildContext context) {
    
    return Column(children: <Widget>[
      BlocBuilder<MainMenuBloc, MainMenuState>( 
        builder: (context, state) { 
          if(isLocked == false){
            BlocProvider.of<MainMenuBloc>(context).add(UnlockEvent());
          }
          if (state is InitialMainMenuState) {
            return MessageDisplay(
              locked: false,
            );
          }
          else if(state is Unlocked){
            return MessageDisplay(
              locked: true,
            );
          }
        }
      ),
      OutlineButton(
        child: Text("Advanced Mode"),
        onPressed: () => goAdvancedMode(context),
      ),
      OutlineButton(
        child: Text("Settings"),
        onPressed: () => showToast(context),
      ),
      OutlineButton(
        child: Text("Sign In"),
        onPressed: () => goLogin(context),
      ),
      OutlineButton(
        child: Text("Register"),
        onPressed: () => goRegister(context),
      ),
      OutlineButton(
        child: Text("Simple Mode"),
        onPressed: () => goSimpleMode(context),
      ),
      OutlineButton(
        child: Text("Map"),
        onPressed: () => goMap(context),
      ),
    ]);
  }

  void showToast(BuildContext context) {
    Toast.show("It's a me, Toastio", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  void goSimpleMode(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SimpleModePage()),
    );
  }

  void goAdvancedMode(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdvancedModePage()),
    );
  }

  void goRegister(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterPage()));
  }

  void goLogin(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void goMap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapPage()),
    );
  }
}
