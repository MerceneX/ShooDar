import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shoodar/core/usecases/usecase.dart';
import 'package:shoodar/core/util/input_converter.dart';
import 'package:shoodar/features/settings/domain/usecases/get_radar_alert_distance.dart';
import 'package:shoodar/features/settings/domain/usecases/set_radar_alert_distance.dart';

import './bloc.dart';

import 'settings_event.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {

  final SetRadarAlertDistance setRadarAlertDistance;
  final GetRadarAlertDistance getRadarAlertDistance;
  final InputConverter inputConverter;

  SettingsBloc({@required SetRadarAlertDistance setRadarAlertDistance, @required GetRadarAlertDistance getRadarAlertDistance, @required this.inputConverter})
      : assert(setRadarAlertDistance != null),
        assert(getRadarAlertDistance != null),
        assert(inputConverter != null),
        setRadarAlertDistance = setRadarAlertDistance,
        getRadarAlertDistance = getRadarAlertDistance;
        
  @override
  SettingsState get initialState => InitState();

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {  
    if (event is RefreshEvent) {
      int distance = await getRadarAlertDistance(NoParams());
      yield InitState(radarAlertDistance: distance.toString());
    }
    else if (event is SaveEvent) {
      final inputEither = inputConverter.stringToUnsignedInteger(event.distance);

      yield* inputEither.fold(
        (failure) async* {
          yield ErrorState(message: failure.message);
        },
        (integer) async* {
          await setRadarAlertDistance(Params(meters: integer));
          yield InitState(radarAlertDistance: integer.toString());
        },
      );     
    }
  }
}