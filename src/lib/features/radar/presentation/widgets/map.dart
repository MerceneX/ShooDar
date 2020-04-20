import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shoodar/features/radar/domain/entitites/radar.dart';

const double CAMERA_ZOOM = 16;

class Map extends StatefulWidget {
  static const LatLng _center = const LatLng(46.056946, 14.505751);

  final List<Radar> radars;

  const Map({
      Key key,
      @required this.radars,
    }) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  final Completer<GoogleMapController> _controller = Completer();
  LocationData currentLocation;
  Location location;

  BitmapDescriptor pinLocationIcon;
  final Set<Marker> _markers = {};

  @override
  void initState() {
      super.initState();

      setCustomMapPin();

      location = new Location();
 
      location.onLocationChanged.listen((LocationData cLoc) {
        currentLocation = cLoc;
      });

      setInitialLocation();
     
  }

  void setInitialLocation() async {
    currentLocation = await location.getLocation();
  }

  void setCustomMapPin() async {
  pinLocationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/icons8-police-car-64.png');
}

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: 7.0,
        target: LatLng(46.056946,  14.505751));

    return Scaffold(
        body: GoogleMap(
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          compassEnabled: true,
          onMapCreated: _onMapCreated,
          markers: _markers,
          initialCameraPosition: initialCameraPosition
            )
      );
  }

   void _onMapCreated(GoogleMapController controller) {
      _addMarkers();
      _controller.complete(controller); 
  }

  void _addMarkers() {
    setState(() {
      widget.radars.forEach((radar) => {
      _markers.add(Marker(
        markerId: MarkerId(radar.id),
        position: LatLng(radar.latitude, radar.longitude),
        infoWindow: InfoWindow(
          title: 'Created at:',
          snippet: radar.timeCreated.toString(),
        ),
        icon: pinLocationIcon
      ))    
    });
    });
  }
}



