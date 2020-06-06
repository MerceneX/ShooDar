import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/features/radar/presentation/bloc/radar_bloc.dart';
import 'package:shoodar/features/radar/presentation/bloc/radar_event.dart';
import 'package:shoodar/features/radar/presentation/bloc/radar_state.dart';
import 'package:shoodar/features/radar/presentation/widgets/loading_widget.dart';
import 'package:vibration/vibration.dart';

import '../../../../injection_container.dart';
import '../widgets/map.dart';

BuildContext radarContext;

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zemljevid'),
      ),
      body: Scaffold(
          body: buildBody(context),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Domov'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                title: Text('Zemljevid'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title: Text('Nastavitve'),
              ),
            ],
            currentIndex: 1,
            selectedItemColor: Colors.amber[800],
            onTap: null,
          ),
          floatingActionButton: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.2,
              child: FloatingActionButton(
                onPressed: () {
                   dispatchAdd(radarContext);
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
              intitalCameraPosition: state.initialCameraPosition,
              radarIsClose: state.radarIsClose);
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
