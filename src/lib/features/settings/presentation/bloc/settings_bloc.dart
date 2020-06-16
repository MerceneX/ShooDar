import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shoodar/core/usecases/usecase.dart';
import 'package:shoodar/core/util/input_converter.dart';
import 'package:shoodar/features/settings/domain/usecases/get_ask_to_add_radar.dart';
import 'package:shoodar/features/settings/domain/usecases/get_notification.dart';
import 'package:shoodar/features/settings/domain/usecases/get_radar_alert_distance.dart';
import 'package:shoodar/features/settings/domain/usecases/get_sound_notification.dart';
import 'package:shoodar/features/settings/domain/usecases/set_ask_to_add_radar.dart';
import 'package:shoodar/features/settings/domain/usecases/set_notification.dart';
import 'package:shoodar/features/settings/domain/usecases/set_radar_alert_distance.dart';
import 'package:shoodar/features/settings/domain/usecases/get_check_radar_periode.dart';
import 'package:shoodar/features/settings/domain/usecases/set_check_radar_periode.dart';
import 'package:shoodar/features/settings/domain/usecases/set_sound_notification.dart';

import './bloc.dart';

import 'settings_event.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {

  final SetRadarAlertDistance setRadarAlertDistance;
  final GetRadarAlertDistance getRadarAlertDistance;
  final SetCheckRadarPeriode setCheckRadarPeriode;
  final GetCheckRadarPeriode getCheckRadarPeriode;
  final SetSoundNotification setSoundNotification;
  final GetSoundNotification getSoundNotification;
  final SetAskToAddRadar setAskToAddRadar;
  final GetAskToAddRadar getAskToAddRadar;
  final SetNotification setNotification;
  final GetNotification getNotification;
  final InputConverter inputConverter;

  SettingsBloc({@required SetRadarAlertDistance setRadarAlertDistance, @required GetRadarAlertDistance getRadarAlertDistance, @required SetCheckRadarPeriode setCheckRadarPeriode, @required GetCheckRadarPeriode getCheckRadarPeriode, @required SetSoundNotification setSoundNotification, @required GetSoundNotification getSoundNotification, @required SetAskToAddRadar setAskToAddRadar, @required GetAskToAddRadar getAskToAddRadar, @required SetNotification setNotification, @required GetNotification getNotification, @required this.inputConverter})
      : assert(setRadarAlertDistance != null),
        assert(getRadarAlertDistance != null),
        assert(setCheckRadarPeriode != null),
        assert(getCheckRadarPeriode != null),
        assert(setSoundNotification != null),
        assert(getSoundNotification != null),
        assert(setAskToAddRadar != null),
        assert(getAskToAddRadar != null),
        assert(setNotification != null),
        assert(getNotification != null),
        assert(inputConverter != null),
        setRadarAlertDistance = setRadarAlertDistance,
        getRadarAlertDistance = getRadarAlertDistance,
        setCheckRadarPeriode = setCheckRadarPeriode,
        getCheckRadarPeriode = getCheckRadarPeriode,
        setSoundNotification = setSoundNotification,
        getSoundNotification = getSoundNotification,
        setAskToAddRadar = setAskToAddRadar,
        getAskToAddRadar = getAskToAddRadar,
        setNotification = setNotification,
        getNotification = getNotification;
        
  @override
  SettingsState get initialState => InitState();

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {  
    if (event is RefreshEvent) {
      int distance = await getRadarAlertDistance(NoParams());
      int periode = await getCheckRadarPeriode(NoParams());
      bool soundNotification = await getSoundNotification(NoParams());
      bool askToAddRadar = await getAskToAddRadar(NoParams());
      bool notification = await getNotification(NoParams());
      yield InitState(radarAlertDistance: distance.toString(), checkRadarPeriode: periode.toString(), soundNotification: soundNotification, askToAddRadar: askToAddRadar, notification: notification);
    }
    else if (event is SaveEvent) {
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

      final soundNotification = event.soundNotification;  
      await setSoundNotification(BoolParams(onOff: soundNotification));

      final askToAddRadar = event.askToAddRadar;  
      await setAskToAddRadar(BoolParams(onOff: askToAddRadar));

      final notification = event.notification;  
      await setNotification(BoolParams(onOff: notification));
    }
  }
}