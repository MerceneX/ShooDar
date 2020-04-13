import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

import '../../domain/usecases/add_radar.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:meta/meta.dart';
import 'radar_event.dart';

class RadarBloc extends Bloc<RadarEvent, RadarState> {
  final AddRadar addRadar;

  RadarBloc({@required AddRadar add})
  : assert(add != null),
    addRadar = add;

  @override
  RadarState get initialState => InitialRadarState();

  @override
  Stream<RadarState> mapEventToState(
    RadarEvent event,
  ) async* {
    if(event is AddRadarEvent) {
      addRadar(NoParams());
    }
  }
}
