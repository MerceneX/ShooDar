import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shoodar/features/main_menu/presentation/bloc/bloc.dart';
import 'package:shoodar/features/radar/domain/entitites/radar.dart';
import 'package:shoodar/features/radar/presentation/bloc/bloc.dart';
import 'package:shoodar/features/radar/presentation/bloc/radar_bloc.dart';
import 'package:shoodar/features/radar/presentation/pages/radar_info_page.dart';
import 'package:intl/intl.dart';

import '../../../../injection_container.dart';

class RadarHistoryList extends StatefulWidget {
  const RadarHistoryList({
    Key key,
    @required this.radars,
  }) : super(key: key);

  final List<Radar> radars;

  @override
  _RadarHistoryListState createState() => _RadarHistoryListState();
}

class _RadarHistoryListState extends State<RadarHistoryList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .color
                      .withOpacity(0.3),
                  border: Border.all(
                      color: Theme.of(context).accentColor.withOpacity(0.8))),
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.3,
              child: buildLogoutButton(context),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .color
                      .withOpacity(0.3),
                  border: Border.all(
                      color: Theme.of(context).accentColor.withOpacity(0.8))),
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.3,
              child: MaterialButton(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        size: 75,
                        color: Theme.of(context).textTheme.bodyText1.color,
                      ),
                      Text(
                        "Profil",
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ]),
                onPressed: null,
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.only(
            top: 20,
          ),
          child: Text(
            "Moji radarji:",
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        Divider(
          color: Theme.of(context).textTheme.bodyText1.color.withOpacity(
                0.7,
              ),
        ),
        Expanded(
            child: Container(
                color: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .color
                    .withOpacity(0.2),
                margin: EdgeInsets.only(left: 15, right: 15, bottom: 5),
                padding: EdgeInsets.only(top: 10, bottom: 5),
                child: ListView(
                  padding: EdgeInsets.only(
                    top: 0,
                    left: 25,
                    right: 25,
                    bottom: 0,
                  ),
                  children: <Widget>[
                    for (Radar radar in widget.radars)
                      Column(
                        children: <Widget>[
                          Card(
                              margin: EdgeInsets.all(0),
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.3),
                              elevation: 3,
                              child: ListTile(
                                  leading: Container(
                                      width: 90,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Badge(
                                          badgeColor: radar.isActive
                                              ? Colors.green
                                              : Colors.red,
                                          shape: BadgeShape.square,
                                          borderRadius: 20,
                                          toAnimate: false,
                                          badgeContent: Text(
                                              radar.isActive
                                                  ? "AKTIVEN"
                                                  : "NEAKTIVEN",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .color,
                                              )),
                                        ),
                                      )),
                                  title: Text(
                                    radar.address,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  subtitle: Text(radar.administrativeArea,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .color
                                            .withOpacity(0.6),
                                      )),
                                  trailing: SizedBox(
                                      width: 50,
                                      child: FlatButton(
                                          child: Icon(Icons.delete,
                                              color: Colors.grey),
                                          onPressed: () => {
                                                _showMyDialog(radar, context),
                                              })),
                                  onTap: () => {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RadarInfoPage(radar: radar)),
                                        )
                                      })),
                        ],
                      )
                  ],
                ))),
      ],
    );
  }

  BlocProvider<MainMenuBloc> buildLogoutButton(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<MainMenuBloc>(),
        child:
            BlocBuilder<MainMenuBloc, MainMenuState>(builder: (context, state) {
          return MaterialButton(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.exit_to_app,
                    size: 75,
                    color: Theme.of(context).textTheme.bodyText1.color,
                  ),
                  Text(
                    "Odjava",
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ]),
            onPressed: () {
              BlocProvider.of<MainMenuBloc>(context).add(LogOutEvent());
              BlocProvider.of<MainMenuBloc>(context).add(RefreshEvent());
              Navigator.pushReplacementNamed(context, "/login");
            },
          );
        }));
  }

  Future<void> _showMyDialog(Radar radar, BuildContext radarContext) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return SimpleDialog(
            titlePadding: EdgeInsets.all(10),
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
            title: Center(
              child: Text('Izbrišem radar?',
                  style: Theme.of(context).textTheme.headline2),
            ),
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: 5,
                  bottom: 25,
                  left: 20,
                  right: 20,
                ),
                child: Text(
                    'Ste prepričani da želite izbrisati radar? To dejanje ne more biti preklicano.',
                    style: Theme.of(context).textTheme.bodyText1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 100,
                    height: 60,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Ne',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  MaterialButton(
                    minWidth: 100,
                    height: 60,
                    textTheme: ButtonTextTheme.primary,
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      setState(() {
                        widget.radars.remove(radar);
                      });
                      BlocProvider.of<RadarBloc>(radarContext)
                          .add(DeleteRadarsEvent(radar.id));
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Da',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }
}
