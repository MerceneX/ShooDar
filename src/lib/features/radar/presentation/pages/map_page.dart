import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/features/main_menu/presentation/widgets/bottom_navigation.dart';
import 'package:shoodar/features/radar/presentation/bloc/radar_bloc.dart';
import 'package:shoodar/features/radar/presentation/bloc/radar_event.dart';
import 'package:shoodar/features/radar/presentation/bloc/radar_state.dart';
import 'package:shoodar/features/radar/presentation/widgets/loading_widget.dart';

import '../../../../injection_container.dart';
import '../widgets/map.dart';

BuildContext radarContext;

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
          body: buildBody(context),
          bottomNavigationBar: BottomNavigation(
            currentPage: 1,
          ),
          floatingActionButton: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.2,
              child: FloatingActionButton(
                onPressed: () async {
                  switch (await showDialog<int>(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          titlePadding: EdgeInsets.only(top: 25),
                          backgroundColor:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                          title: Center(
                            child: Text('Dodam radar?',
                                style: Theme.of(context).textTheme.headline2),
                          ),
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                MaterialButton(
                                  minWidth: 100,
                                  height: 60,
                                  color: Theme.of(context).primaryColor,
                                  onPressed: () {
                                    Navigator.pop(context, 0);
                                  },
                                  child: Text(
                                    'Ne',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                                MaterialButton(
                                  minWidth: 100,
                                  height: 60,
                                  textTheme: ButtonTextTheme.primary,
                                  color: Theme.of(context).accentColor,
                                  onPressed: () {
                                    Navigator.pop(context, 1);
                                  },
                                  child: Text(
                                    'Da',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      })) {
                    case 1:
                      dispatchAdd(radarContext);
                      break;
                    case 0:
                      break;
                  }
                },
                child: Icon(
                  Icons.linked_camera,
                  size: MediaQuery.of(context).size.height * 0.15,
                ),
              ))),
    );
  }

  BlocProvider<RadarBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RadarBloc>(),
      child: BlocBuilder<RadarBloc, RadarState>(builder: (context, state) {
        dispatchGetRadars(context);
        if (state is InitialRadarState) {
          return LoadingWidget();
        } else if (state is Loading) {
          return LoadingWidget();
        } else if (state is Loaded) {
          radarContext = context;
          return Map(
              radars: state.radars,
              location: state.location,
              controller: state.controller,
              intitalCameraPosition: state.initialCameraPosition);
        } else {
          return null;
        }
      }),
    );
  }

  void dispatchAdd(context) {
    BlocProvider.of<RadarBloc>(context).add(AddRadarEvent());
  }

  dispatchGetRadars(context) {
    BlocProvider.of<RadarBloc>(context).add(LoadMapEvent());
  }
}
