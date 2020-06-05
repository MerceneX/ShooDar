import 'package:flutter/material.dart';

class MessageDisplay extends StatelessWidget {
  final String message;

  const MessageDisplay({
    Key key,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 15),
      child: Center(
        child: SingleChildScrollView(
          child: Text(message, style: Theme.of(context).textTheme.headline2),
        ),
      ),
    );
  }
}
