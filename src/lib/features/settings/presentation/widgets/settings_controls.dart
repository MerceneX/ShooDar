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

  const SettingsForm({
    Key key,
    this.currentDistance,
    this.currentPeriode,
    this.currentSoundNotification,
    this.currentAskToAddRadar,
    this.currentNotification,
    this.error,
  }) : super(key: key);

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

    if (soundNotification == null) {
      soundNotification = widget.currentSoundNotification;
    }
    if (askToAddRadar == null) {
      askToAddRadar = widget.currentAskToAddRadar;
    }
    if (notification == null) {
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
                      labelText: "Koliko m pred radarjem opozorim?",
                      labelStyle: Theme.of(context).textTheme.bodyText1,
                      hintText: widget.currentDistance,
                    ),
                    style: Theme.of(context).textTheme.bodyText1,
                  )),
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
                      labelText: "Na koliko sec preverim za radarje?",
                      labelStyle: Theme.of(context).textTheme.bodyText1,
                      hintText: widget.currentPeriode,
                    ),
                    style: Theme.of(context).textTheme.bodyText1,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: Text(
                      "Na radar opozorim z zvokom?",
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  Switch(
                      value: soundNotification,
                      onChanged: (value) {
                        setState(() {
                          soundNotification = value;
                          dispatchSave();
                        });
                      }),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: Text(
                      "Zahtevam potrditev preden dodam?",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Switch(
                      value: askToAddRadar,
                      onChanged: (value) {
                        setState(() {
                          askToAddRadar = value;
                          dispatchSave();
                        });
                      }),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: Text(
                      "Omogočim potisna obvestila?",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Switch(
                    value: notification,
                    onChanged: (value) {
                      setState(() {
                        notification = value;
                        dispatchSave();
                      });
                    },
                  ),
                ],
              ),
              Divider(),
              Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: MaterialButton(
                      highlightElevation: 1.0,
                      elevation: 3.0,
                      height: 80,
                      minWidth: 150,
                      color: Theme.of(context).primaryColor.withOpacity(0.8),
                      child: Text(
                        "Shrani",
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
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "Spremembe zabeležene",
                          ),
                        ));
                      }))
            ]));
  }

  void dispatchSave() {
    String dispatchDistance = distance;
    String dispatchPeriode = periode;
    if (distance == null || distance == "") {
      dispatchDistance = widget.currentDistance;
    }
    if (periode == null || periode == "") {
      dispatchPeriode = widget.currentPeriode;
    }
    BlocProvider.of<SettingsBloc>(context).add(SaveEvent(dispatchDistance,
        dispatchPeriode, soundNotification, askToAddRadar, notification));
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
