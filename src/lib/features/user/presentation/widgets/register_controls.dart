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
  bool _obscureText = true;

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
                        fillColor: Theme.of(context).textTheme.headline2.color,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: 'E-Pošta',
                        hintStyle: TextStyle(
                            color: Theme.of(context).textTheme.headline2.color),
                        errorText: null,
                        prefixIcon: Icon(
                          Icons.email,
                          color: Theme.of(context).textTheme.headline2.color,
                        )),
                    style: Theme.of(context).textTheme.bodyText1,
                    autofocus: true,
                    enableSuggestions: true,
                  )),
              TextField(
                controller: controllerPassword,
                obscureText: _obscureText,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: 'Geslo',
                    hintStyle: TextStyle(
                        color: Theme.of(context).textTheme.headline2.color),
                    errorText: null,
                    prefixIcon: Icon(Icons.security,
                        color: Theme.of(context).textTheme.headline2.color),
                    suffixIcon: GestureDetector(
                      child: Icon(
                        Icons.remove_red_eye,
                        color: Theme.of(context)
                            .textTheme
                            .headline2
                            .color
                            .withOpacity(0.5),
                      ),
                      onTap: _toggle,
                    )),
                style: Theme.of(context).textTheme.bodyText1,
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
                              Theme.of(context).primaryColor.withOpacity(0.75),
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          child: Text(
                            "Registriraj se",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          onPressed: () => dispatchRegister())))
            ]));
  }

  void dispatchRegister() {
    BlocProvider.of<UserBloc>(context)
        .add(RegisterUserEvent(username, password));
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
