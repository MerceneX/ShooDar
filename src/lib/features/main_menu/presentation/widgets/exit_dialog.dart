import 'dart:io';

import 'package:flutter/material.dart';

class ExitAppDialog extends StatelessWidget {
  const ExitAppDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Želite zapustiti aplikacijo?"),
      actions: <Widget>[
        FlatButton(
          child: Text("Ne"),
          onPressed: () => Navigator.pop(context, false),
        ),
        FlatButton(
          child: Text("Da"),
          onPressed: () => exit(0),
        )
      ],
    );
  }
}
