import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/features/main_menu/presentation/widgets/bottom_navigation.dart';
import 'package:shoodar/features/radar/presentation/pages/map_page.dart';
import 'package:shoodar/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:shoodar/features/settings/presentation/bloc/settings_state.dart';
import 'package:shoodar/features/settings/presentation/widgets/settings_controls.dart';
import 'package:shoodar/injection_container.dart';

class SettingsPage extends StatelessWidget {
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
                    top: MediaQuery.of(context).size.height * 0.1),
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
                        Text('Nastavitve',
                            style: Theme.of(context).textTheme.headline1),
                      ],
                    )),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          top: 20, left: 20, right: 20, bottom: 30),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .color
                              .withOpacity(0.4)),
                      child: buildBody(context)),
                ],
              )),
          bottomNavigationBar: BottomNavigation(
            currentPage: 2,
          ),
        ));
  }

  BlocProvider<SettingsBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<SettingsBloc>(),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, state) {
                  if (state is InitState) {
                    return SettingsForm(
                        currentDistance: state.radarAlertDistance.toString(),
                        currentPeriode: state.checkRadarPeriode.toString(),
                        currentSoundNotification: state.soundNotification,
                        currentAskToAddRadar: state.askToAddRadar,
                        currentNotification: state.notification,
                        error: null);
                  } else if (state is ErrorState) {
                    return SettingsForm(
                        currentDistance: "",
                        currentPeriode: "",
                        error: state.message);
                  }
                },
              ),
            ]));
  }

  _redirect(BuildContext context) async {
    await Navigator.of(context).pushReplacementNamed(
      '/map',
    );
  }
}
