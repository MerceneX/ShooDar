import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/features/user/presentation/bloc/bloc.dart';
import 'package:shoodar/features/user/presentation/pages/register_user.dart';

class LoginForm extends StatefulWidget {
  final String emailError;
  final String passwordError;

  final String firebaseError;
  const LoginForm({
    Key key,
    this.emailError,
    this.passwordError,
    this.firebaseError,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
            Widget>[
          Container(
              padding: EdgeInsets.only(bottom: 25),
              child: TextField(
                controller: controllerUsername,
                onChanged: (emailValue) {
                  username = emailValue;
                },
                onSubmitted: (_) {
                  dispatchLogin();
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: 'E-Pošta',
                    errorText: widget.emailError,
                    prefixIcon: Icon(
                      Icons.email,
                    )),
                style: Theme.of(context).textTheme.bodyText1,
                autofocus: true,
                enableSuggestions: true,
              )),
          TextField(
            controller: controllerPassword,
            obscureText: _obscureText,
            decoration: InputDecoration(
                hintText: 'Geslo',
                errorText: widget.passwordError,
                prefixIcon: Icon(
                  Icons.security,
                ),
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
              dispatchLogin();
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Še nimate računa?",
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.bodyText1.fontFamily,
                  )),
              MaterialButton(
                  padding: EdgeInsets.only(left: 5),
                  child: Text("Registrirajte se!",
                      style: TextStyle(
                        fontFamily:
                            Theme.of(context).textTheme.bodyText1.fontFamily,
                        color: Theme.of(context).textTheme.bodyText1.color,
                      )),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage())))
            ],
          ),
          firebaseErrors(),
          Padding(
              padding: EdgeInsets.only(top: 75),
              child: MaterialButton(
                  highlightElevation: 1.0,
                  elevation: 3.0,
                  height: 75,
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "Vpišite se",
                    style: new TextStyle(
                        fontSize: 35,
                        color: Theme.of(context).textTheme.bodyText1.color,
                        fontFamily:
                            Theme.of(context).textTheme.bodyText1.fontFamily),
                  ),
                  onPressed: () => dispatchLogin()))
        ]));
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget firebaseErrors() {
    if (widget.firebaseError != null && widget.firebaseError != "") {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.red),
        ),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        child: Text(widget.firebaseError,
            style: Theme.of(context).textTheme.bodyText1),
      );
    } else {
      return Container();
    }
  }

  void dispatchLogin() {
    BlocProvider.of<UserBloc>(context).add(LoginUserEvent(username, password));
  }
}
