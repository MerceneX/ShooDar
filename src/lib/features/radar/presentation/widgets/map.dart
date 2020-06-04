import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shoodar/features/radar/presentation/bloc/bloc.dart';
import 'package:shoodar/features/user/domain/entities/user_location.dart';

class Map extends StatefulWidget {
  final Set<Marker> radars;
  final UserLocation location;
  final Completer<GoogleMapController> controller;
  final CameraPosition intitalCameraPosition;

  const Map(
      {Key key,
      @required this.radars,
      @required this.controller,
      @required this.intitalCameraPosition,
      this.location})
      : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  LocationData currentLocation;
  Location location;

  @override
  void initState() {
    super.initState();

    location = new Location();

    location.onLocationChanged.listen((LocationData cLoc) {
      currentLocation = cLoc;
      updatePinOnMap();
    });

    setInitialLocation();
  }

  void setInitialLocation() async {
    currentLocation = await location.getLocation();
  }

  void updatePinOnMap() async {
    CameraPosition cPosition = CameraPosition(
      zoom: 16.0,
      tilt: 80,
      bearing: 30,
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
    );

    final GoogleMapController controller = await widget.controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            compassEnabled: true,
            onMapCreated: _onMapCreated,
            markers: widget.radars,
            initialCameraPosition: widget.intitalCameraPosition),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Domov'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              title: Text('Zemljevid'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Nastavitve'),
            ),
          ],
          currentIndex: 1,
          selectedItemColor: Colors.amber[800],
          onTap: null,
        ),
        floatingActionButton: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.2,
            child: FloatingActionButton(
              onPressed: () {},
              child: Icon(
                Icons.linked_camera,
                size: MediaQuery.of(context).size.height * 0.15,
              ),
            )));
  }

  void _onMapCreated(GoogleMapController controller) {
    widget.controller.complete(controller);
  }

  void dispatchUpdateLocation(
      Set<Marker> markers, Completer<GoogleMapController> controller) {
    BlocProvider.of<RadarBloc>(context)
        .add(LocationChangedEvent(markers, controller));
  }
}
