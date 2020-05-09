
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/features/radar/presentation/bloc/radar_bloc.dart';
import 'package:shoodar/features/radar/presentation/bloc/radar_event.dart';
import 'package:shoodar/features/radar/presentation/bloc/radar_state.dart';
import 'package:shoodar/features/radar/presentation/widgets/loading_widget.dart';
import 'package:shoodar/features/radar/presentation/widgets/message_display.dart';


import '../../../../injection_container.dart';
import '../widgets/map.dart';



class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: buildBody(context),
    );
  }


BlocProvider<RadarBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RadarBloc>(),
      child: BlocBuilder<RadarBloc, RadarState>(
        builder: (context, state){

          dispatchGetRadars(context);
          if(state is InitialRadarState) {
            return MessageDisplay(
              message: "Loading radars");
          } else if(state is Loading) {
            return LoadingWidget();
          } else if(state is Loaded) {
            return Map(
              radars: state.radars, 
              location: state.location, 
              controller: state.controller, 
              intitalCameraPosition: state.initialCameraPosition);
          }                 
        }),
    );
  }

  dispatchGetRadars(context) {
    BlocProvider.of<RadarBloc>(context).add(LoadMapEvent());
  }
}





