
import 'package:meta/meta.dart';

class Radar {
  final DateTime timeCreated;
  final DateTime timeDeleted;
  final double latitude;
  final double longitude;

  Radar({
    @required this.timeCreated,
    @required this.latitude,
    @required this.longitude,
    this.timeDeleted
  });

}