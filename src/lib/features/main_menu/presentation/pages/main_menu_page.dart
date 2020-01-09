import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/features/radar/presentation/bloc/bloc.dart';
import 'package:toast/toast.dart';

import '../../../../injection_container.dart';
import '../../../radar/presentation/widgets/message_display.dart';

class MainMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<RadarBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RadarBloc>(),
      child: Column(children: <Widget>[
        OutlineButton(child: Text("Advanced Mode"), onPressed: null),
        OutlineButton(
          child: Text("Settings Mode"),
          onPressed: () => showToast(context),
        ),
        OutlineButton(
          child: Text("Sign Up Mode"),
          onPressed: null,
        ),
        OutlineButton(
          child: Text("Register Mode"),
          onPressed: null,
        ),
        OutlineButton(
          child: Text("Simple Mode"),
          onPressed: null,
        ),
      ]),
    );
  }

  void showToast(BuildContext context) {
    Toast.show("It's a me, Toastio", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }
}
