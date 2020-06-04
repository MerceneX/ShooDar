import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/features/main_menu/presentation/pages/main_menu_page.dart';
import 'package:shoodar/features/user/presentation/bloc/user_bloc.dart';
import 'package:shoodar/features/user/presentation/bloc/user_state.dart';
import 'package:shoodar/features/user/presentation/widgets/display_message.dart';
import 'package:shoodar/features/user/presentation/widgets/login_controls.dart';
import 'package:shoodar/injection_container.dart';

class LoginPage extends StatelessWidget {
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
            child: Column(children: <Widget>[
              LoginForm(),
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is InitialUserState) {
                    return MessageDisplay(
                      message: 'Log in please',
                    );
                  } else if (state is AuthSuccess) {
                    MainMenuPage.isLocked = false;
                    return MessageDisplay(
                      message: 'LoggedIn',
                    );
                  } else if (state is LoginValidationErrorState) {
                    return MessageDisplay(
                      message: state.emailError + "\n" + state.passwordError,
                    );
                  } else if (state is Error) {
                    return MessageDisplay(
                      message: state.message,
                    );
                  } else {
                    return MessageDisplay(
                        message: "Ni bilo najdenega stanje, poskusite kasneje");
                  }
                },
              ),
            ])));
  }
}
