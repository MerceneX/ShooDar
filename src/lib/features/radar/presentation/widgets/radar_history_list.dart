import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shoodar/features/radar/domain/entitites/radar.dart';
import 'package:shoodar/features/radar/presentation/bloc/bloc.dart';
import 'package:shoodar/features/radar/presentation/bloc/radar_bloc.dart';
import 'package:shoodar/features/radar/presentation/pages/radar_info_page.dart';
import 'package:intl/intl.dart';


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
    return ListView(
      children: <Widget>[
        for (Radar radar in widget.radars)
          Column(
            children: <Widget>[
              ListTile(
                  leading:
                      SizedBox(
                        width: 90 ,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Badge(
                            badgeColor: radar.isActive ? Colors.green : Colors.red,
                            shape: BadgeShape.square,
                            borderRadius: 20,
                            toAnimate: false,
                            badgeContent:
                            Text(radar.isActive ? "AKTIVEN" : "NEAKTIVEN", style: TextStyle(color: Colors.white)),
                          ),
                      )),
                  title: Text(radar.address),
                  subtitle: Text(radar.administrativeArea),
                  trailing: SizedBox(
                      width: 50,
                      child: FlatButton(
                          child: Icon(Icons.delete, color: Colors.grey),
                          onPressed: () => {
                                _showMyDialog(radar, context),
                              })
                  ),
                  onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RadarInfoPage(radar: radar)),
                        )
                      }),
              Divider(),
            ],
          )
      ],
    );
  }

  Future<void> _showMyDialog(Radar radar, BuildContext radarContext) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Brisanje radarja'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Si prepričan/a da želis izbrisati radar? To dejanje ne more biti preklicano.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Da'),
              onPressed: () {
                setState(() {
                  widget.radars.remove(radar);
                });
                BlocProvider.of<RadarBloc>(radarContext)
                    .add(DeleteRadarsEvent(radar.id));
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Ne'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
