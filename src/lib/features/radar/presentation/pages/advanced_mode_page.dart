import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/features/radar/domain/entitites/radar.dart';
import 'package:shoodar/features/radar/presentation/bloc/bloc.dart';
import 'package:shoodar/features/radar/presentation/widgets/loading_widget.dart';
import 'package:shoodar/features/radar/presentation/widgets/radar_history_list.dart';

import '../../../../injection_container.dart';

class AdvancedModePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moji radarji'),
        centerTitle: true,
      ),
      body: buildBody(context),
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
