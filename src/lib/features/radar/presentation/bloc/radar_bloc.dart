import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shoodar/features/radar/domain/entitites/radar.dart';
import 'package:shoodar/features/radar/domain/usecases/get_all_radars.dart';
import './bloc.dart';

import '../../domain/usecases/add_radar.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:meta/meta.dart';
import 'radar_event.dart';

class RadarBloc extends Bloc<RadarEvent, RadarState> {
  final AddRadar addRadar;
  final GetAllRadars getRadars;

  RadarBloc({
    @required AddRadar add,
    @required GetAllRadars getRadars
    })
  :  assert(add!= null),
     assert(getRadars != null),
        addRadar = add,
        getRadars = getRadars;


  @override
  RadarState get initialState => InitialRadarState();

  @override
  Stream<RadarState> mapEventToState(
    RadarEvent event,
  ) async* {
    if(event is AddRadarEvent) {
      addRadar(NoParams());
    } else if(event is GetRadarsEvent) {
      List<Radar> radars = await getRadars(NoParams());
      yield* _eitherLoadedOrErrorState(radars);
      
    }
  }
}

Stream<RadarState> _eitherLoadedOrErrorState(
     List<Radar> radars,
  ) async* {
    yield Loaded(radars);
  }
