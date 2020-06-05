import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/features/main_menu/presentation/pages/main_menu_page.dart';
import 'package:shoodar/features/user/presentation/bloc/user_bloc.dart';
import 'package:shoodar/features/user/presentation/bloc/bloc.dart';
import 'package:shoodar/features/user/presentation/widgets/display_message.dart';
import 'package:shoodar/features/user/presentation/widgets/register_controls.dart';

import '../../../../injection_container.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registracija'),
      ),
      backgroundColor: Theme.of(context).textTheme.bodyText1.color,
      body: ListView(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Container(
              color: Theme.of(context).accentColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Shoo', style: Theme.of(context).textTheme.headline1),
                  Text('Dar', style: Theme.of(context).textTheme.headline1)
                ],
              )),
        ),
        buildBody(context)
      ]),
    );
  }

  BlocProvider<UserBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<UserBloc>(),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.65,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.03,
              left: MediaQuery.of(context).size.width * 0.02,
              right: MediaQuery.of(context).size.width * 0.02,
            ),
            child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1,
                  left: MediaQuery.of(context).size.width * 0.10,
                  right: MediaQuery.of(context).size.width * 0.10,
                  bottom: MediaQuery.of(context).size.height * 0.02,
                ),
                decoration: BoxDecoration(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    border: Border.all(
                        color: Theme.of(context).accentColor,
                        style: BorderStyle.solid,
                        width: 3)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          if (state is InitialUserState) {
                            return MessageDisplay(
                              message: 'Registrirajte se',
                            );
                          } else if (state is AuthSuccess) {
                            MainMenuPage.isLocked = false;
                            return MessageDisplay(
                              message: 'Registered',
                            );
                          } else if (state
                              is RegistrationValidationErrorState) {
                            return MessageDisplay(
                              message:
                                  state.emailError + "\n" + state.passwordError,
                            );
                          } else if (state is Error) {
                            return MessageDisplay(
                              message: "Random err",
                            );
                          } else {
                            return MessageDisplay(
                              message: "W00t?!",
                            );
                          }
                        },
                      ),
                      RegisterForm(),
                    ]))));
  }
}
