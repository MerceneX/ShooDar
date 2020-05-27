import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/features/radar/presentation/bloc/bloc.dart';
import 'package:shoodar/features/radar/presentation/widgets/big_add_radar_button.dart';

import '../../../../injection_container.dart';
import '../bloc/bloc.dart';

class SimpleModePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: buildBody(context),
    );
  }

  BlocProvider<RadarBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<RadarBloc>(),
        child: Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50, bottom: 50),
                child: Container(
                    color: Theme.of(context).accentColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Shoo',
                            style: Theme.of(context).textTheme.headline1),
                        Text('Dar',
                            style: Theme.of(context).textTheme.headline1)
                      ],
                    )),
              ),
              BigAddRadarButton()
            ])));
  }
}
