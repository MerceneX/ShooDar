import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/features/main_menu/presentation/widgets/bottom_navigation.dart';
import 'package:shoodar/features/main_menu/presentation/widgets/exit_dialog.dart';
import 'package:shoodar/features/radar/presentation/bloc/radar_bloc.dart';
import 'package:shoodar/features/radar/presentation/bloc/radar_event.dart';
import 'package:shoodar/features/radar/presentation/bloc/radar_state.dart';
import 'package:shoodar/features/radar/presentation/widgets/loading_widget.dart';
import 'package:shoodar/features/radar/presentation/widgets/radar_confirmtion_dialog.dart';
import 'package:shoodar/features/radar/presentation/widgets/login_first_dialog.dart';

import '../../../../injection_container.dart';
import '../widgets/map.dart';

BuildContext radarContext;
bool isUserLoggedIn;
bool addRadarConfirm;

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => showDialog(
              context: context,
              builder: (context) => ExitAppDialog(),
            ),
        child: Scaffold(
          body: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: buildBody(context)),
          bottomNavigationBar: BottomNavigation(
            currentPage: 1,
          ),
          floatingActionButton: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.2,
              child: FloatingActionButton(
                onPressed: () async {
                  getUserConfirmation(context);
                },
                child: Icon(
                  Icons.linked_camera,
                  size: MediaQuery.of(context).size.height * 0.15,
                ),
              )),
        ));
  }

  BlocProvider<RadarBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RadarBloc>(),
      child: BlocBuilder<RadarBloc, RadarState>(builder: (context, state) {
        dispatchGetRadars(context);
        if (state is InitialRadarState) {
          return LoadingWidget();
        } else if (state is Loading) {
          return LoadingWidget();
        } else if (state is Loaded) {
          radarContext = context;
          isUserLoggedIn = state.isUserLoggedIn;
          addRadarConfirm = state.askToAddRadar;
          return Map(
              radars: state.markers,
              location: state.location,
              controller: state.controller,
              intitalCameraPosition: state.initialCameraPosition,
              periode: state.checkRadarPeriode);
        } else {
          return null;
        }
      }),
    );
  }

  void dispatchAdd(context) {
    BlocProvider.of<RadarBloc>(context).add(AddRadarEvent());
  }

  dispatchGetRadars(context) {
    BlocProvider.of<RadarBloc>(context).add(LoadMapEvent());
  }

  void getUserConfirmation(BuildContext context) async {
    if (isUserLoggedIn == true) {
      if(addRadarConfirm == true){
        switch (await showDialog<int>(
            context: context,
            builder: (BuildContext context) {
              return RadarUserConfirmationDialog();
            })) {
          case 1:
            dispatchAdd(radarContext);
            break;
          case 0:
            break;
        }
      } 
      else {
        dispatchAdd(radarContext);
      }     
    }
    else{
        await showDialog<int>(
          context: context,
          builder: (BuildContext context) {
            return LoginFirstDialog();
          });
    }
  }
}
