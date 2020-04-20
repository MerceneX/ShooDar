import '../../domain/entitites/radar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class RadarDataSource {
  void addRadar(Radar radar);
  Future<List<Radar>> getAllRadars();
  Future<void> deleteRadar(String id);

}

class RadarDataSourceImpl implements RadarDataSource {
  final databaseRef = Firestore.instance;

  @override
  void addRadar(Radar radar) async {
    await databaseRef.collection("radars").add({
          'timeCreated': new DateTime.now(),
          'location': new GeoPoint(radar.latitude, radar.longitude)
    });
  }

  @override
  Future<List<Radar>> getAllRadars() async {
    List<Radar> allRadars = new List();
    QuerySnapshot snapshot = await databaseRef.collection("radars").getDocuments();
    
    snapshot.documents.forEach((radar) => {
      allRadars.add( new Radar(
        id: radar.documentID,
        timeCreated: radar.data['timeCreated'].toDate(),
        latitude: radar.data['location'].latitude,
        longitude: radar.data['location'].longitude,
        timeDeleted: radar.data['timeDeleted']
      ))
    });
    return allRadars;
  }

  @override
  Future<void> deleteRadar(String id) async {
    databaseRef
        .collection('radars')
        .document(id)
        .delete();
  }
}
