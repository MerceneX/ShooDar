import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/features/user/presentation/bloc/bloc.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    Key key,
    String emailError,
    String passwordError,
  }) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  String username;
  String password;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(bottom: 25),
                  child: TextField(
                    controller: controllerUsername,
                    onChanged: (emailValue) {
                      username = emailValue;
                    },
                    onSubmitted: (_) {
                      dispatchRegister();
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'E-Pošta',
                        errorText: null,
                        prefixIcon: Icon(Icons.email)),
                    autofocus: true,
                    enableSuggestions: true,
                  )),
              TextField(
                controller: controllerPassword,
                obscureText: true,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Geslo',
                    errorText: null,
                    prefixIcon: Icon(Icons.security)),
                onChanged: (passwordValue) {
                  password = passwordValue;
                },
                onSubmitted: (_) {
                  dispatchRegister();
                },
              ),
              Padding(
                  padding: EdgeInsets.only(top: 75),
                  child: ButtonTheme(
                      minWidth: 300,
                      height: 80.0,
                      child: RaisedButton(
                          highlightElevation: 1.0,
                          splashColor: Theme.of(context).primaryColor,
                          highlightColor: Theme.of(context).primaryColor,
                          elevation: 3.0,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.85),
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          child: Text(
                            "Potrdi",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          onPressed: () => dispatchRegister())))
            ]));
  }

  void dispatchRegister() {
    BlocProvider.of<UserBloc>(context)
        .add(RegisterUserEvent(username, password));
  }
}
