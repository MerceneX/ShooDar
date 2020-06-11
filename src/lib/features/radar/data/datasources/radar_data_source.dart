import 'package:geolocator/geolocator.dart';

import '../../domain/entitites/radar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class RadarDataSource {
  void addRadar(Radar radar, String uid);
  Future<List<Radar>> getAllRadars();
  Future<List<Radar>> getRadarsById(String id);
  Future<void> deleteRadar(String id);
  void updateRadar(Radar radar);

}

class RadarDataSourceImpl implements RadarDataSource {
  
  final databaseRef = Firestore.instance;

  @override
  void addRadar(Radar radar, String uid) async {
    await databaseRef.collection("radars").add({
          'timeCreated': new DateTime.now(),
          'location': new GeoPoint(radar.latitude, radar.longitude),
          'userUid': uid,
          'isActive': true
    });
  }

  @override
  Future<List<Radar>> getAllRadars() async {
    List<Radar> allRadars = new List();
    QuerySnapshot snapshot = await databaseRef.collection("radars").getDocuments();

    for(int i = 0; i < snapshot.documents.length; i++) {
      var radar = snapshot.documents[i];

      List<String> fullAddress = await getAddressFromRadarLocation(radar.data['location'].latitude, radar.data['location'].longitude);

      Duration difference = DateTime.now().difference(radar.data['timeCreated'].toDate());

      allRadars.add( new Radar(
          id: radar.documentID,
          timeCreated: radar.data['timeCreated'].toDate(),
          latitude: radar.data['location'].latitude,
          longitude: radar.data['location'].longitude,
          timeDeleted: radar.data['timeDeleted'],
          userId: radar.data['userUid'],
          address: fullAddress[0],
          administrativeArea:fullAddress[1],
          isActive: radar.data['isActive']
      ));
    }
    return allRadars;
  }

  Future<List<String>> getAddressFromRadarLocation(double lat, double long) async{
    List<Placemark> placemarks = await Geolocator().placemarkFromCoordinates(lat, long);

    return placemarks.length > 0 ? [placemarks[0].thoroughfare + " " + placemarks[0].name, placemarks[0].administrativeArea] : ["", ""];
  }

  @override
  Future<void> deleteRadar(String id) async {
    databaseRef
        .collection('radars')
        .document(id)
        .delete();
  }

  @override
  Future<List<Radar>> getRadarsById(String id) async {
    List<Radar> radars = await getAllRadars();

    radars = radars.where((element) => element.userId == id).toList();

    return radars;
  }

  @override
  void updateRadar(Radar radar) {
    databaseRef.
      collection('radars')
      .document(radar.id)
      .updateData(({
          'timeCreated': radar.timeCreated,
          'location': new GeoPoint(radar.latitude, radar.longitude),
          'userUid': radar.userId,
          'isActive': radar.isActive  
    }));
  }
}
