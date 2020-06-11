import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/features/main_menu/presentation/widgets/bottom_navigation.dart';
import 'package:shoodar/features/radar/domain/entitites/radar.dart';
import 'package:shoodar/features/radar/presentation/bloc/radar_bloc.dart';
import 'package:shoodar/features/radar/presentation/bloc/radar_event.dart';
import 'package:shoodar/features/radar/presentation/bloc/radar_state.dart';
import 'package:shoodar/features/radar/presentation/widgets/loading_widget.dart';
import 'package:shoodar/features/radar/presentation/widgets/radar_confirmtion_dialog.dart';
import 'package:shoodar/features/radar/presentation/widgets/login_first_dialog.dart';
import 'package:shoodar/features/radar/presentation/widgets/radar_info.dart';

import '../../../../injection_container.dart';
import '../widgets/map.dart';

BuildContext radarContext;
bool isUserLoggedIn;

class RadarInfoPage extends StatefulWidget {
  const RadarInfoPage({
    Key key,
    @required this.radar,
  }) : super(key: key);

  final Radar radar;

  @override
  _RadarInfoPage createState() => _RadarInfoPage();
}

class _RadarInfoPage extends State<RadarInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Podrobnosti'),
        actions: <Widget>[
          SizedBox(
              width: 90,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Badge(
                  badgeColor: widget.radar.isActive ? Colors.green : Colors.red,
                  shape: BadgeShape.square,
                  borderRadius: 20,
                  toAnimate: false,
                  badgeContent: Text(
                      widget.radar.isActive ? "AKTIVEN" : "NEAKTIVEN",
                      style: TextStyle(color: Colors.white)),
                ),
              )),
        ],
        centerTitle: true,
      ),
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0, 1.7),
              colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor,
              ],
            ),
          ),
          child: Container(
              child: Column(
            children: <Widget>[
              Expanded(
                child: buildBody(context),
              ),
            ],
          ))),
      bottomNavigationBar: BottomNavigation(
        currentPage: 0,
      ),
    );
  }

  BlocProvider<RadarBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RadarBloc>(),
      child: BlocBuilder<RadarBloc, RadarState>(builder: (context, state) {
        return RadarInfo(radar: widget.radar);
      }),
    );
  }
}
