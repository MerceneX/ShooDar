import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/features/main_menu/presentation/bloc/main_menu_bloc.dart';
import 'package:shoodar/features/main_menu/presentation/bloc/main_menu_event.dart';
import 'package:shoodar/features/main_menu/presentation/bloc/main_menu_state.dart';
import 'package:shoodar/features/main_menu/presentation/widgets/display_message.dart';
import 'package:shoodar/features/main_menu/presentation/widgets/main_menuItem.dart';
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
      backgroundColor: Theme.of(context).primaryColor,
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

  Padding buildNavigation(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 15.0),
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 50, bottom: 50),
            child: Container(
                color: Theme.of(context).accentColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Shoo', style: Theme.of(context).textTheme.headline1),
                    Text('Dar', style: Theme.of(context).textTheme.headline1)
                  ],
                )),
          ),
          Container(
              height: MediaQuery.of(context).size.height - 205,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).accentColor,
                    style: BorderStyle.solid,
                    width: 3),
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
                      text: "Enostaven Način",
                      height: 200,
                      fontSize: 55.0,
                      padding: EdgeInsets.only(bottom: 50, top: 25),
                      onPressed: () => goSimpleMode(context),
                    ),
                    MainMenuItem(
                      text: "Zemljevid",
                      onPressed: () => goMap(context),
                    ),
                    MainMenuItem(
                      text: "Podrobnosti",
                      onPressed: () => goAdvancedMode(context),
                    ),
                    MainMenuItem(
                      text: "Nastavitve",
                      onPressed: () => showToast(context),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        MainMenuItem(
                          text: "Registacija",
                          onPressed: () => goRegister(context),
                        ),
                        MainMenuItem(
                          text: "Vpis",
                          onPressed: () => goLogin(context),
                        ),
                      ],
                    ),
                    BlocBuilder<MainMenuBloc, MainMenuState>(
                        builder: (context, state) {
                      if (isLocked == false) {
                        BlocProvider.of<MainMenuBloc>(context)
                            .add(UnlockEvent());
                        return null;
                      }
                      if (state is InitialMainMenuState) {
                        return MessageDisplay(
                          locked: false,
                        );
                      } else if (state is Unlocked) {
                        return MessageDisplay(
                          locked: true,
                        );
                      }
                      return null;
                    })
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
