import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class RadarBloc extends Bloc<RadarEvent, RadarState> {
  @override
  RadarState get initialState => InitialRadarState();

  @override
  Stream<RadarState> mapEventToState(
    RadarEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
