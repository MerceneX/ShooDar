import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/core/validators/validators.dart';
import 'package:shoodar/features/main_menu/presentation/bloc/user_bloc.dart';
import 'package:shoodar/features/main_menu/presentation/widgets/custom_form_textfield.dart';
import 'package:toast/toast.dart';

import '../../../../injection_container.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registracija'),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<UserBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<UserBloc>(),
        child: Container(
            padding: EdgeInsets.only(top: 15),
            child: Column(children: <Widget>[RegisterForm()])));
  }

  void showToast(BuildContext context) {
    Toast.show("It's a me, Toastio", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }
}

class RegisterForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterFormState();
  }
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Registrirajte se",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline1),
              GeneralTextField(
                  icon: Icon(Icons.email),
                  hint: "Vnesite email",
                  onSaved: null,
                  validator: (value) => emailValidator(value)),
              GeneralTextField(
                icon: Icon(Icons.security),
                hint: "Vnesite geslo",
                onSaved: null,
                validator: (value) => passwordValidator(value),
              ),
              GeneralTextField(
                icon: Icon(Icons.security),
                hint: "Ponovite geslo",
                onSaved: null,
                validator: (value) => passwordValidator(value),
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
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          onPressed: () => validateForm())))
            ]));
  }

  void validateForm() {
    final FormState form = _formKey.currentState;
    if (_formKey.currentState.validate()) {
      Toast.show("Form validated", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  void showToast(BuildContext context) {
    Toast.show("It's a me, Toastio", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }
}
