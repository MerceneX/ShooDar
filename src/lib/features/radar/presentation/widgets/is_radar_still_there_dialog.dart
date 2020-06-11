import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/features/radar/domain/entitites/radar.dart';
import 'package:shoodar/features/radar/presentation/bloc/radar_bloc.dart';
import 'package:shoodar/features/radar/presentation/bloc/radar_event.dart';
import 'package:shoodar/features/radar/presentation/bloc/radar_state.dart';

import '../../../../injection_container.dart';

class IsRadarThereDialog extends StatelessWidget {
  const IsRadarThereDialog({
    Key key,
    @required this.radar
  }) : super(key: key);

  final Radar radar;

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }
  void dispatchUpdateRadar(BuildContext context, Radar radar) {
    BlocProvider.of<RadarBloc>(context).add(UpdateRadarEvent(radar));
  }

  BlocProvider<RadarBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RadarBloc>(),
      child: BlocBuilder<RadarBloc, RadarState>(builder: (context, state) {
        return SimpleDialog(
          titlePadding: EdgeInsets.all(10),
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
          title: Center(
            child:
                Text('Je radar še v bližini?', style: Theme.of(context).textTheme.headline2),
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
                    radar.isActive = false;
                    dispatchUpdateRadar(context, radar);
                    Navigator.pop(context, 0);
                  },
                  child: Text(
                    'Ne',
                    style: Theme.of(context).textTheme.bodyText1,
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
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            )
          ],
    );
      }),
    );
  }
  
}


