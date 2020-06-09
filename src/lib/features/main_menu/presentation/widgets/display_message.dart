import 'package:flutter/material.dart';

class MessageDisplay extends StatelessWidget {
  final bool loggedIn;

  const MessageDisplay({
    Key key,
    @required this.loggedIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
       
          child: Text(
            "Logged in: " + loggedIn.toString(),
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
      
      ),
    );
  }
}