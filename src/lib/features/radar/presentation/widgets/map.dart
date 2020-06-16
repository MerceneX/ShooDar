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
  final int periode;

  const Map(
      {Key key,
      @required this.radars,
      @required this.controller,
      @required this.intitalCameraPosition,
      @required this.periode,
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

    var period = Duration(seconds: widget.periode);
    new Timer.periodic(
        period, (Timer t) => {
          if (context != null) {
            dispatchCheckIfRadarIsClose(context)
          }
        });

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
   
    if(context != null) {
      controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GoogleMap(
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            compassEnabled: true,
            onMapCreated: _onMapCreated,
            markers: widget.radars,
            initialCameraPosition: widget.intitalCameraPosition));
  }

  void _onMapCreated(GoogleMapController controller) {
    widget.controller.complete(controller);
  }

  void dispatchCheckIfRadarIsClose(BuildContext context) {
    BlocProvider.of<RadarBloc>(context).add(LocationChangedEvent(context));
  }
}
