import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:shoodar/features/settings/presentation/bloc/settings_event.dart';

class SettingsForm extends StatefulWidget {
  final String currentDistance;
  final String currentPeriode;
  final bool currentSoundNotification;
  final bool currentAskToAddRadar;
  final bool currentNotification;
  final String error;

  const SettingsForm(
      {Key key, this.currentDistance, this.currentPeriode, this.currentSoundNotification, this.currentAskToAddRadar, this.currentNotification, this.error})
      : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  final controllerDistance = TextEditingController();
  final controllerPeriode = TextEditingController();
  String distance;
  String periode;
  bool soundNotification;
  bool askToAddRadar;
  bool notification;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showInfoFlushbar(context);
  });

  if(soundNotification == null){
    soundNotification = widget.currentSoundNotification;
  }
  if(askToAddRadar == null){
    askToAddRadar = widget.currentAskToAddRadar;
  }
  if(notification == null){
    notification = widget.currentNotification;
  }

  WidgetsBinding.instance.addPostFrameCallback((_) => dispatchRefresh());
    return Form(
        key: _formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(bottom: 25),
                  child: TextField(
                    controller: controllerDistance,
                    onChanged: (distanceValue) {        
                      distance = distanceValue;
                    },
                    onSubmitted: (_) {
                      dispatchSave();
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Radar alert distance(meters)",
                        hintText: widget.currentPeriode
                    ),
                    style: Theme.of(context).textTheme.bodyText1,
                    autofocus: true,
                    enableSuggestions: true,                    
                  )
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 25),
                  child: TextField(
                    controller: controllerPeriode,
                    onChanged: (periodeValue) {
                      periode = periodeValue;
                    },
                    onSubmitted: (_) {
                      dispatchSave();
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Chech for radar every __ (s)",
                        hintText: widget.currentPeriode
                    ),
                    style: Theme.of(context).textTheme.bodyText1,
                    autofocus: true,
                    enableSuggestions: true,                    
                  )
                ),
                
                /*Switch(
                  value: soundNotification,
                  onChanged: (value){
                  setState(() {
                    soundNotification=value;
                    dispatchSave();
                  }
                );*/
                /*Switch(
                  value: askToAddRadar,
                  onChanged: (value){
                  setState(() {
                    askToAddRadar=value;
                    dispatchSave();
                  }
                );*/
                Switch(
                  value: notification,
                  onChanged: (value){
                  setState(() {
                    notification=value;
                    dispatchSave();
                  }
                );
          },
          activeTrackColor: Colors.lightGreenAccent,
          activeColor: Colors.green,
        ),
              Padding(
                  padding: EdgeInsets.only(top: 75),
                  child: MaterialButton(
                      highlightElevation: 1.0,
                      elevation: 3.0,
                      height: 75,
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        "Save",
                        style: new TextStyle(
                            fontSize: 35,
                            color: Theme.of(context).textTheme.bodyText1.color,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .fontFamily),
                      ),
                      onPressed: () {
                        dispatchSave();
                      }))
            ]));
  }

  void dispatchSave() {
    String dispatchDistance = distance;
    String dispatchPeriode = periode;
    if(distance == null || distance == ""){
      dispatchDistance = widget.currentDistance;
    }
    if(periode == null || periode == ""){
      dispatchPeriode = widget.currentPeriode;
    }
    BlocProvider.of<SettingsBloc>(context).add(SaveEvent(dispatchDistance, dispatchPeriode, soundNotification, askToAddRadar, notification));
  }

  void dispatchRefresh() {
    BlocProvider.of<SettingsBloc>(context).add(RefreshEvent());
  }

  void showInfoFlushbar(BuildContext context) {
    if (widget.error != null && widget.error != "") {
      Flushbar(
        messageText: Text(
          widget.error,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        icon: Icon(
          Icons.error_outline,
          size: 28,
          color: Colors.red.shade300,
        ),
        leftBarIndicatorColor: Colors.red.shade300,
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        duration: Duration(seconds: 30),
      )..show(context);
    }
  }


  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
