import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/features/main_menu/presentation/bloc/main_menu_bloc.dart';
import 'package:shoodar/features/main_menu/presentation/bloc/main_menu_event.dart';
import 'package:shoodar/features/main_menu/presentation/pages/log_out_page.dart';
import 'package:shoodar/features/main_menu/presentation/widgets/display_message.dart';
import 'package:shoodar/features/main_menu/presentation/widgets/main_menuItem.dart';
import 'package:shoodar/features/radar/presentation/pages/advanced_mode_page.dart';
import 'package:shoodar/features/radar/presentation/pages/map_page.dart';
import 'package:shoodar/features/radar/presentation/pages/simple_mode_page.dart';
import 'package:shoodar/features/user/presentation/pages/login_user.dart';
import 'package:shoodar/features/user/presentation/pages/register_user.dart';
import 'package:toast/toast.dart';

class MenuItems extends StatefulWidget {

  final bool loggedIn;

  const MenuItems({
    Key key,
    @required this.loggedIn,
  }) : super(key: key);

  @override
  _MenuItemsState createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => dispatchRefresh());
    return ListView(
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
        MessageDisplay(
          loggedIn: widget.loggedIn,
        ),
      ]
    );
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
    BlocProvider.of<MainMenuBloc>(context).add(LogOutEvent());
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

  void dispatchRefresh() {
    BlocProvider.of<MainMenuBloc>(context).add(RefreshEvent());
  }
}
