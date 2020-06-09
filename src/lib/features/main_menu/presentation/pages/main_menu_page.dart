import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/features/main_menu/presentation/bloc/main_menu_bloc.dart';
import 'package:shoodar/features/main_menu/presentation/bloc/main_menu_event.dart';
import 'package:shoodar/features/main_menu/presentation/bloc/main_menu_state.dart';
import 'package:shoodar/features/main_menu/presentation/widgets/display_message.dart';
import 'package:shoodar/features/main_menu/presentation/widgets/main_menuItem.dart';
import 'package:shoodar/features/radar/presentation/pages/simple_mode_page.dart';
import 'package:shoodar/features/main_menu/presentation/pages/log_out_page.dart';
import 'package:shoodar/features/radar/presentation/pages/advanced_mode_page.dart';
import 'package:shoodar/features/user/presentation/pages/login_user.dart';
import 'package:shoodar/features/user/presentation/pages/register_user.dart';
import 'package:shoodar/features/radar/presentation/pages/map_page.dart';
import '../../../../core/usersState/usersState.dart';
import 'package:toast/toast.dart';
import '../../../../injection_container.dart';

class MainMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showDialog(
      context: context,
      builder: (context)=>AlertDialog(
        title: Text("Do you want to exit app?"),
        actions: <Widget>[
          FlatButton(
            child: Text("No"),
            onPressed: ()=>Navigator.pop(context, false),
          ),
          FlatButton(
            child: Text("Yes"),
            onPressed: ()=>exit(0),
         )],
       )
      ),
      child: Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
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
                      height: 175,
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
                    MainMenuItem(
                      text: "Odjava",
                      onPressed: () => goLogOut(context),
                    ),
                    MainMenuItem(
                      text: "Registacija",
                      onPressed: () => goRegister(context),
                    ),
                    MainMenuItem(
                      text: "Vpis",
                      onPressed: () => goLogin(context),
                    ),
                    BlocBuilder<MainMenuBloc, MainMenuState>(
                        builder: (context, state) {
                      if (UsersState.signedIn == true) {
                        BlocProvider.of<MainMenuBloc>(context).add(UnlockEvent());
                      }
                      if (UsersState.signedIn == false) {
                        BlocProvider.of<MainMenuBloc>(context).add(LockEvent());
                      }
                      if (state is NavigationState) {
                        return MessageDisplay(
                          loggedIn: false,
                        );
                      } else if (state is Unlocked) {
                        return MessageDisplay(
                          loggedIn: true,
                        );
                      }
                      else if (state is Locked) {
                        return MessageDisplay(
                          loggedIn: false,
                        );
                      }
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

  void goLogOut(BuildContext context) {
    UsersState.signedIn = false;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LogOutPage()),
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
