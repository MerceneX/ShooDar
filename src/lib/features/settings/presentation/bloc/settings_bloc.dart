import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shoodar/core/usecases/usecase.dart';
import 'package:shoodar/core/util/input_converter.dart';
import 'package:shoodar/features/settings/domain/usecases/get_radar_alert_distance.dart';
import 'package:shoodar/features/settings/domain/usecases/set_radar_alert_distance.dart';
import 'package:shoodar/features/settings/domain/usecases/get_check_radar_periode.dart';
import 'package:shoodar/features/settings/domain/usecases/set_check_radar_periode.dart';

import './bloc.dart';

import 'settings_event.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {

  final SetRadarAlertDistance setRadarAlertDistance;
  final GetRadarAlertDistance getRadarAlertDistance;
  final SetCheckRadarPeriode setCheckRadarPeriode;
  final GetCheckRadarPeriode getCheckRadarPeriode;
  final InputConverter inputConverter;

  SettingsBloc({@required SetRadarAlertDistance setRadarAlertDistance, @required GetRadarAlertDistance getRadarAlertDistance, @required SetCheckRadarPeriode setCheckRadarPeriode, @required GetCheckRadarPeriode getCheckRadarPeriode, @required this.inputConverter})
      : assert(setRadarAlertDistance != null),
        assert(getRadarAlertDistance != null),
        assert(setCheckRadarPeriode != null),
        assert(getCheckRadarPeriode != null),
        assert(inputConverter != null),
        setRadarAlertDistance = setRadarAlertDistance,
        getRadarAlertDistance = getRadarAlertDistance,
        setCheckRadarPeriode = setCheckRadarPeriode,
        getCheckRadarPeriode = getCheckRadarPeriode;
        
  @override
  SettingsState get initialState => InitState();

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {  
    if (event is RefreshEvent) {
      int distance = await getRadarAlertDistance(NoParams());
      int periode = await getCheckRadarPeriode(NoParams());
      yield InitState(radarAlertDistance: distance.toString(), checkRadarPeriode: periode.toString());
    }
    else if (event is SaveEvent) {print(event.distance);
      final distanceInput = inputConverter.stringToUnsignedInteger(event.distance);
      yield* distanceInput.fold(
        (failure) async* {
          yield ErrorState(message: failure.message);
        },
        (integer) async* {
          await setRadarAlertDistance(DistanceParams(meters: integer));
          yield InitState(radarAlertDistance: integer.toString());
        },
      );    
print(event.periode);
      final periodeInput = inputConverter.stringToUnsignedInteger(event.periode);
      yield* periodeInput.fold(
        (failure) async* {
          yield ErrorState(message: failure.message);
        },
        (integer) async* {
          await setCheckRadarPeriode(PeriodeParams(seconds: integer));
          yield InitState(checkRadarPeriode: integer.toString());
        },
      );    
    }
  }
}