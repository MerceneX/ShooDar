import 'package:equatable/equatable.dart';
import 'package:shoodar/features/radar/domain/entitites/radar.dart';

abstract class RadarState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialRadarState extends RadarState {}

 class Loading extends RadarState {}

class Loaded extends RadarState {
  final List<Radar> radars;

  Loaded(this.radars);

  @override
  List<Object> get props => [radars];
}
  

