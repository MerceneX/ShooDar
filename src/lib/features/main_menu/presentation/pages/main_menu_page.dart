import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/features/main_menu/presentation/widgets/main_menuItem.dart';
import 'package:shoodar/features/radar/presentation/bloc/bloc.dart';
import 'package:shoodar/features/radar/presentation/pages/simple_mode_page.dart';
import 'package:shoodar/features/radar/presentation/pages/advanced_mode_page.dart';
import 'package:shoodar/features/user/presentation/pages/register_user.dart';
import 'package:shoodar/features/radar/presentation/pages/map_page.dart';

import 'package:toast/toast.dart';

import '../../../../injection_container.dart';

class MainMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<RadarBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<RadarBloc>(),
        child: Center(child: buildNavigation(context)));
  }

  Padding buildNavigation(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 15.0, left: 1.0),
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 50, bottom: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Shoo', style: Theme.of(context).textTheme.headline1),
                Text('Dar', style: Theme.of(context).textTheme.headline1)
              ],
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height - 205,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100.0),
                    bottomRight: Radius.circular(50)),
              ),
              child: ListView(
                  primary: false,
                  reverse: true,
                  padding: EdgeInsets.only(left: 50.0, top: 50.0, right: 10.0),
                  children: <Widget>[
                    MainMenuItem(
                      text: "Simple Mode",
                      height: 200,
                      fontSize: 65.0,
                      padding: EdgeInsets.only(bottom: 50, top: 25),
                      onPressed: () => goSimpleMode(context),
                    ),
                    MainMenuItem(
                      text: "Map",
                      onPressed: () => goMap(context),
                    ),
                    MainMenuItem(
                      text: "Advanced Mode",
                      onPressed: () => goAdvancedMode(context),
                    ),
                    MainMenuItem(
                      text: "Sign In",
                      onPressed: () => {},
                    ),
                    MainMenuItem(
                      text: "Register",
                      onPressed: () => goRegister(context),
                    ),
                    MainMenuItem(
                      text: "Settings",
                      onPressed: () => showToast(context),
                    ),
                  ]))
        ]));
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

  void goMap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapPage()),
    );
  }
}
