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
      appBar: AppBar(
        title: Text('Simple Mode'),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<RadarBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<RadarBloc>(),
        child: BigAddRadarButton(
          leftHanded: false,
        ));
  }

  // BlocProvider<RadarBloc> buildBody(BuildContext context) {
  //   return BlocProvider(
  //       create: (_) => sl<RadarBloc>(),
  //       child: BlocBuilder<RadarBloc, RadarState>(
  //         builder: (context, state) {
  //           return BigAddRadarButton(
  //             leftHanded: false);
  //         }
  //       )
  //     );
  // }               
}
