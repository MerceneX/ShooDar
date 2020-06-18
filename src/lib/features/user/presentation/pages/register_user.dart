import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/features/main_menu/presentation/widgets/bottom_navigation.dart';
import 'package:shoodar/features/radar/presentation/pages/map_page.dart';
import 'package:shoodar/features/radar/presentation/widgets/loading_widget.dart';
import 'package:shoodar/features/user/presentation/bloc/user_bloc.dart';
import 'package:shoodar/features/user/presentation/bloc/bloc.dart';
import 'package:shoodar/features/user/presentation/widgets/display_message.dart';
import 'package:shoodar/features/user/presentation/widgets/register_controls.dart';

import '../../../../injection_container.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MapPage()),
            ),
        child: Scaffold(
          body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0, 1.7),
                  colors: <Color>[
                    Theme.of(context).primaryColor,
                    Theme.of(context).accentColor,
                  ],
                ),
              ),
              child: ListView(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2),
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment(0.5, 7),
                        colors: <Color>[
                          Theme.of(context).primaryColor,
                          Theme.of(context).accentColor,
                        ],
                      ),
                    ),
                    child: Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('ShooDar',
                            style: Theme.of(context).textTheme.headline1),
                      ],
                    )),
                  ),
                  buildBody(context)
                ],
              )),
          bottomNavigationBar: BottomNavigation(
            currentPage: 0,
          ),
        ));
  }

  BlocProvider<UserBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<UserBloc>(),
        child: Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.03,
              left: MediaQuery.of(context).size.width * 0.02,
              right: MediaQuery.of(context).size.width * 0.02,
            ),
            child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                  left: MediaQuery.of(context).size.width * 0.10,
                  right: MediaQuery.of(context).size.width * 0.10,
                  bottom: MediaQuery.of(context).size.height * 0.02,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          if (state is InitialUserState) {
                            return RegisterForm();
                          } else if (state is InProgressState) {
                            return LoadingWidget();
                          } else if (state is AuthSuccess) {
                            WidgetsBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              _redirect(context);
                            });
                            return MessageDisplay(
                              message: 'Registracija uspešna',
                            );
                          } else if (state
                              is RegistrationValidationErrorState) {
                            return RegisterForm(
                              emailError: state.emailError,
                              passwordError: state.passwordError,
                            );
                          } else if (state is Error) {
                            return RegisterForm(
                              firebaseError: state.message,
                            );
                          } else {
                            return MessageDisplay(
                              message: "W00t?!",
                            );
                          }
                        },
                      ),
                    ]))));
  }

  _redirect(BuildContext context) async {
    await Navigator.of(context).pushReplacementNamed(
      '/map',
    );
  }
}
