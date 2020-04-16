
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/core/util/ui/get_screen_measures.dart';
import 'package:toast/toast.dart';

import '../bloc/bloc.dart';
import '../bloc/radar_event.dart';



  class BigAddRadarButton extends StatefulWidget {
    final bool leftHanded;
    
    const BigAddRadarButton({
      Key key,
      @required this.leftHanded,
    }) : super(key: key);

    @override
      _BigAddRadarButtonState createState() => _BigAddRadarButtonState();   
  }

  class _BigAddRadarButtonState extends State<BigAddRadarButton> {
    @override
    Widget build(BuildContext context) {
      ScreenProperties screenProperties = ScreenProperties(context);

      return Container(
        alignment: widget.leftHanded ? Alignment.bottomLeft : Alignment.bottomRight,
        child: GestureDetector(
            child: ClipRRect(
                borderRadius:
                    new BorderRadius.only(topLeft: const Radius.circular(180.0)),
                child: Container(
                  color: Colors.red,
                  width: screenProperties.width * 0.9,
                  height: screenProperties.getHeightWOutSafeArea() * 0.7,
                  child: Center(
                    child: Text("RADAR"),
                  ),
                )),
            onTap: () {
              dispatchAdd();    
              showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel:
                      MaterialLocalizations.of(context).modalBarrierDismissLabel,
                  barrierColor: Colors.black45,
                  transitionDuration: const Duration(milliseconds: 200),
                  pageBuilder: (BuildContext buildContext, Animation animation,
                      Animation secondaryAnimation) {
                    return FractionallySizedBox(
                        heightFactor: 1,
                        widthFactor: 1,
                        child: Container(
                          width: screenProperties.width * 0.9,
                          height:
                              screenProperties.getHeightWOutStatusAndToolBar(),
                          color: Colors.orangeAccent,
                          child: GestureDetector(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {                                
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      child: Center(child: Text("Ne")),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      child: Center(child: Text("Da")),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () => Toast.show(
                                  "It's a me, Toastio", context,
                                  duration: Toast.LENGTH_SHORT,
                                  gravity: Toast.BOTTOM)),
                        ));
                  });
            }),
      );
    }

  void dispatchAdd() {
    BlocProvider.of<RadarBloc>(context).add(AddRadarEvent());
  }
}


class RadarAddConfirmationDialog extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return AlertDialog(
        title: Text("Dodaj Radar?"),
        actions: <Widget>[
          FlatButton(child: Text("Da"), onPressed: null),
          FlatButton(
              child: Text("Ne"),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      );
    }
  }