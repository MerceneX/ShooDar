
import 'package:equatable/equatable.dart';
import 'package:location/location.dart';

abstract class RadarEvent extends Equatable {
  const RadarEvent();
}

// class Loading extends RadarEvent {
//   @override
//   List<Object> get props => null;
// }

class AddRadarEvent extends RadarEvent {
  AddRadarEvent();

  @override
  List<Object> get props => null;
}

class LoadMapEvent extends RadarEvent {
  LoadMapEvent();

  @override
  List<Object> get props => [];
}

class LocationChangedEvent extends RadarEvent {
  final LocationData loc;
  LocationChangedEvent(this.loc);

  @override
  List<Object> get props => [LocationChangedEvent(loc)];
}
