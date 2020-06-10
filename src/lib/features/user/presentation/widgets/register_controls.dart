import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/features/user/presentation/bloc/bloc.dart';
import 'package:shoodar/features/user/presentation/pages/login_user.dart';

class RegisterForm extends StatefulWidget {
  final String emailError;
  final String passwordError;
  final String firebaseError;
  const RegisterForm(
      {Key key, this.emailError, this.passwordError, this.firebaseError})
      : super(key: key);

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showInfoFlushbar(context);
    });
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Že imate račun?",
                      style: TextStyle(
                        fontFamily:
                            Theme.of(context).textTheme.bodyText1.fontFamily,
                      )),
                  MaterialButton(
                      padding: EdgeInsets.only(left: 5),
                      child: Text("Vpišite se!",
                          style: TextStyle(
                            fontFamily: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .fontFamily,
                            color: Theme.of(context).textTheme.bodyText1.color,
                          )),
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage())))
                ],
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
                      }))
            ]));
  }

  void dispatchRegister() {
    BlocProvider.of<UserBloc>(context)
        .add(RegisterUserEvent(username, password));
  }

  void showInfoFlushbar(BuildContext context) {
    if (widget.firebaseError != null && widget.firebaseError != "") {
      Flushbar(
        messageText: Text(
          widget.firebaseError,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        icon: Icon(
          Icons.error_outline,
          size: 28,
          color: Colors.red.shade300,
        ),
        leftBarIndicatorColor: Colors.red.shade300,
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
