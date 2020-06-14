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
            currentPage: 2,
          ),
        ));
  }

  BlocProvider<SettingsBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<SettingsBloc>(),
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
                      BlocBuilder<SettingsBloc, SettingsState>(
                        builder: (context, state) {                          
                          if (state is InitState) {                        
                            return SettingsForm(currentDistance: state.radarAlertDistance.toString(), error: null);
                          } 
                          else if (state is ErrorState) {  
                            return SettingsForm(currentDistance: "", error: state.message);                      
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