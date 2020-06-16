import 'package:equatable/equatable.dart';
import 'package:shoodar/core/usecases/usecase.dart';
import 'package:shoodar/features/settings/domain/repositories/settings_repository.dart';

class SetCheckRadarPeriode implements UseCase<void, PeriodeParams> {
  final SettingsRepository repository;

  SetCheckRadarPeriode(this.repository);

  @override
  Future<void> call(PeriodeParams params) async {
    return await repository.setCheckRadarPeriode(params.seconds);
  }
}

class PeriodeParams extends Equatable {
  final int seconds;

  PeriodeParams({this.seconds});

  @override
  List<Object> get props => [seconds];
}