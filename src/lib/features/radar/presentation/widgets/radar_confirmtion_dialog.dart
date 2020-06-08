import 'package:flutter/material.dart';

class RadarUserConfirmationDialog extends StatelessWidget {
  const RadarUserConfirmationDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      titlePadding: EdgeInsets.only(top: 25),
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
      title: Center(
        child:
            Text('Dodam radar?', style: Theme.of(context).textTheme.headline2),
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
  }
}
