import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/features/main_menu/presentation/bloc/bloc.dart';
import 'package:shoodar/features/main_menu/presentation/widgets/bottom_navigation.dart';
import 'package:shoodar/features/main_menu/presentation/widgets/display_message.dart';
import 'package:shoodar/features/radar/domain/entitites/radar.dart';
import 'package:shoodar/features/radar/presentation/bloc/bloc.dart';
import 'package:shoodar/features/radar/presentation/pages/map_page.dart';
import 'package:shoodar/features/radar/presentation/widgets/loading_widget.dart';
import 'package:shoodar/features/radar/presentation/widgets/radar_history_list.dart';

import '../../../../injection_container.dart';

class AdvancedModePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => showDialog(
              context: context,
              builder: (context) => MapPage(),
            ),
        child: Scaffold(
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
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment(0.5, 7),
                            colors: <Color>[
                              Theme.of(context).primaryColor,
                              Theme.of(context).accentColor,
                            ],
                          ),
                        ),
                        child: Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('ShooDar',
                                style: Theme.of(context).textTheme.headline1),
                          ],
                        )),
                      ),
                      Expanded(
                        child: buildContent(context),
                      ),
                    ],
                  ))),
          bottomNavigationBar: BottomNavigation(
            currentPage: 0,
          ),
        ));
  }

  void dispatchLoginCheck(BuildContext context) {
    BlocProvider.of<MainMenuBloc>(context).add(RefreshEvent());
  }

  BlocProvider<RadarBloc> buildContent(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<RadarBloc>(),
        child: BlocBuilder<RadarBloc, RadarState>(builder: (context, state) {
          dispatchGetRadars(context);
          if (state is InitialRadarState) {
            return LoadingWidget();
          } else if (state is Loading) {
            return LoadingWidget();
          } else if (state is Loaded) {
            return RadarHistoryList(radars: state.radars);
          } else {
            return null;
          }
        }));
  }

  dispatchGetRadars(context) {
    BlocProvider.of<RadarBloc>(context).add(GetRadarsEvent());
  }
}
