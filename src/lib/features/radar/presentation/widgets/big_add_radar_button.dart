import 'package:flutter/material.dart';
import 'package:shoodar/core/ui/util/get_screen_measures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

import '../bloc/bloc.dart';
import '../bloc/radar_event.dart';

class BigAddRadarButton extends StatefulWidget {
  const BigAddRadarButton({
    Key key,
  }) : super(key: key);

  @override
  _BigAddRadarButtonState createState() => _BigAddRadarButtonState();
}

class _BigAddRadarButtonState extends State<BigAddRadarButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
          child: Container(
              height: MediaQuery.of(context).size.height - 205,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).accentColor,
                    style: BorderStyle.solid,
                    width: 3),
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100.0),
                    bottomRight: Radius.circular(50)),
              ),
              child: Center(
                  child: RotatedBox(
                quarterTurns: 0,
                child: Text("Dodaj radar",
                    style: new TextStyle(
                        fontFamily:
                            Theme.of(context).textTheme.bodyText1.fontFamily,
                        color: Theme.of(context).textTheme.bodyText1.color,
                        fontSize: 80.0,
                        fontWeight: FontWeight.w700)),
              ))),
          onTap: () {
            dispatchAdd();
          }),
    );
  }

  void dispatchAdd() {
    BlocProvider.of<RadarBloc>(context).add(AddRadarEvent());
  }
}
