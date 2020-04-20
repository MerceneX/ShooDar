import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/features/radar/presentation/bloc/bloc.dart';
import 'package:shoodar/features/radar/presentation/pages/simple_mode_page.dart';
import 'package:shoodar/features/radar/presentation/pages/advanced_mode_page.dart';
import 'package:shoodar/features/user/presentation/pages/register_user.dart';
import 'package:toast/toast.dart';

import '../../../../injection_container.dart';

class MainMenuPage extends StatelessWidget {
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

  BlocProvider<RadarBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<RadarBloc>(),
        child: Center(child: buildNavigation(context)));
  }

  Column buildNavigation(BuildContext context) {
    return Column(children: <Widget>[
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
        onPressed: null,
      ),
      OutlineButton(
        child: Text("Register"),
        onPressed: () => goRegister(context),
      ),
      OutlineButton(
        child: Text("Simple Mode"),
        onPressed: () => goSimpleMode(context),
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
}
