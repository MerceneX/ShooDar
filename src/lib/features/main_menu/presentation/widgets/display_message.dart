import 'package:flutter/material.dart';

class MessageDisplay extends StatelessWidget {
  final bool locked;

  const MessageDisplay({
    Key key,
    @required this.locked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: SingleChildScrollView(
          child: Text(
            "Logged in: " + locked.toString(),
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}