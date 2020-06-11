import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/features/main_menu/presentation/bloc/main_menu_bloc.dart';
import 'package:shoodar/features/main_menu/presentation/bloc/main_menu_event.dart';
import 'package:shoodar/features/main_menu/presentation/bloc/main_menu_state.dart';
import 'package:shoodar/features/main_menu/presentation/widgets/menu_items.dart';
import '../../../../injection_container.dart';

class MainMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Želite zapustiti aplikacijo?"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Ne"),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                  FlatButton(
                    child: Text("Da"),
                    onPressed: () => exit(0),
                  )
                ],
              )),
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
              child: BlocBuilder<MainMenuBloc, MainMenuState>(
                  builder: (context, state) {
                BlocProvider.of<MainMenuBloc>(context).add(RefreshEvent());
                if (state is NavigationState) {
                  return MenuItems(loggedIn: false);
                } else if (state is LoggedIn) {
                  return MenuItems(loggedIn: true);
                } else if (state is LoggedOut) {
                  return MenuItems(loggedIn: false);
                } else {
                  return null;
                }
              }))
        ]));
  }
}
