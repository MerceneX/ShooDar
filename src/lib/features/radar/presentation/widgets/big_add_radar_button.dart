import 'package:flutter/material.dart';
import 'package:shoodar/core/util/ui/get_screen_measures.dart';
import 'package:toast/toast.dart';

class BigAddRadarButton extends StatelessWidget {
  final bool leftHanded;

  const BigAddRadarButton({
    Key key,
    @required this.leftHanded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenProperties screenProperties = ScreenProperties(context);

    return Container(
      alignment: leftHanded ? Alignment.bottomLeft : Alignment.bottomRight,
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
          onTap: () => Toast.show(
              "Why in the fuck is this not yet implemented", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM)),
    );
  }
}
