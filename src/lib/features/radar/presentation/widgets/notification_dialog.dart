import 'package:flutter/material.dart';

class RadarAlertDialog extends StatelessWidget {
  const RadarAlertDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      titlePadding: EdgeInsets.all(10),
      backgroundColor: Theme.of(context).accentColor.withOpacity(0.5),
      title: Center(
        child: Text('Radar v bližini!',
            style: Theme.of(context).textTheme.headline2),
      ),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            MaterialButton(
              minWidth: 100,
              height: 60,
              textTheme: ButtonTextTheme.primary,
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.pop(context, 1);
              },
              child: Text(
                'Ok',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        )
      ],
    );
  }
}
