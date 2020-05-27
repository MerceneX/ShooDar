import 'package:flutter/material.dart';

class MainMenuItem extends MaterialButton {
  MainMenuItem(
      {this.onPressed,
      this.text = "Default Text",
      this.height = 70.0,
      this.fontSize = 40.0,
      this.padding = const EdgeInsets.only(top: 10, left: 25)});

  final VoidCallback onPressed;
  final String text;
  final EdgeInsets padding;
  final double fontSize;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding,
        child: MaterialButton(
          height: height,
          color: Theme.of(context).primaryColor,
          elevation: 3,
          child: Text(
            text,
            style: new TextStyle(
                fontSize: fontSize,
                color: Theme.of(context).textTheme.bodyText1.color,
                fontFamily: Theme.of(context).textTheme.bodyText1.fontFamily),
          ),
          onPressed: onPressed,
        ));
  }
}
