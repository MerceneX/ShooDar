import 'dart:async';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoodar/features/radar/domain/entitites/radar.dart';
import 'package:intl/intl.dart';

class RadarInfo extends StatefulWidget {
  const RadarInfo({
    Key key,
    @required this.radar,
  }) : super(key: key);

  final Radar radar;

  @override
  _RadarInfo createState() => _RadarInfo();
}

class _RadarInfo extends State<RadarInfo> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    Set<Marker> _markers = new Set<Marker>();

    _markers.add(new Marker(
        markerId: MarkerId(widget.radar.id),
        position: LatLng(widget.radar.latitude, widget.radar.longitude)));

    return Container(
        child: Column(
      children: <Widget>[
        SizedBox(
          width:
              MediaQuery.of(context).size.width, // or use fixed size like 200
          height: MediaQuery.of(context).size.height / 2.5,
          child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                  target: LatLng(widget.radar.latitude, widget.radar.longitude),
                  zoom: 15),
              markers: _markers,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              }),
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: SizedBox(
                    width: 30, height: 150, child: Icon(Icons.location_city)),
                title: Text("Naslov"),
                subtitle: Text(widget.radar.address),
              ),
              Divider(),
              ListTile(
                leading: SizedBox(
                    width: 30, height: 150, child: Icon(Icons.location_on)),
                title: Text("Upravna Enota"),
                subtitle: Text(widget.radar.administrativeArea),
              ),
              Divider(),
              ListTile(
                leading: SizedBox(
                    width: 30, height: 150, child: Icon(Icons.schedule)),
                title: Text("Ustvarjen"),
                subtitle: Text(DateFormat("dd.MM.yyyy ob HH:mm")
                    .format(widget.radar.timeCreated.toLocal())),
              ),
              Divider(),
            ],
          ),
        )
      ],
    ));
  }
}
