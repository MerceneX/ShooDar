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
  final bool radarIsClose;

  const Map(
      {Key key,
      @required this.radars,
      @required this.controller,
      @required this.intitalCameraPosition,
      this.location,
      @required this.radarIsClose,})
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

    const period = const Duration(seconds:30);
    new Timer.periodic(period, (Timer t) => {
        location.onLocationChanged.listen((LocationData cLoc) {
        currentLocation = cLoc;
        updatePinOnMap();
        dispatchUpdateLocation(cLoc);
      })
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
    if (widget.radarIsClose) {
      _showMyDialog();
    }
    return Container(
        child: GoogleMap(
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          compassEnabled: true,
          onMapCreated: _onMapCreated,
          markers: widget.radars,
          initialCameraPosition: widget.intitalCameraPosition
      )
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    widget.controller.complete(controller);
  }

  void dispatchUpdateLocation(LocationData loc){
    BlocProvider.of<RadarBloc>(context).add(LocationChangedEvent(loc));
  }

  Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('This is a demo alert dialog.'),
              Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Approve'),
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
