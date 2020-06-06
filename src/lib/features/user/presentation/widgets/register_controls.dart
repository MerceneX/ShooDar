import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/features/user/presentation/bloc/bloc.dart';

class RegisterForm extends StatefulWidget {
  final String emailError;
  final String passwordError;
  const RegisterForm({
    Key key,
    @required this.emailError,
    @required this.passwordError,
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
                  dispatchRegister();
                },
              ),
              Padding(
                  padding: EdgeInsets.only(top: 75),
                  child: MaterialButton(
                      highlightElevation: 1.0,
                      elevation: 3.0,
                      height: 75,
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        "Registrirajte se",
                        style: new TextStyle(
                            fontSize: 35,
                            color: Theme.of(context).textTheme.bodyText1.color,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .fontFamily),
                      ),
                      onPressed: () {
                        dispatchRegister();
                        _formKey.currentState.reset();
                      }))
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
