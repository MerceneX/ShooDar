import 'package:shoodar/core/usecases/usecase.dart';
import 'package:shoodar/features/main_menu/domain/repositories/main_menu_repository.dart';

class IsUserLoggedIn implements UseCase<void, NoParams> {
  final MainMenuRepository repository;

  IsUserLoggedIn(this.repository);

  @override
  Future<bool> call(NoParams params) async {
    return await repository.isUserLoggedIn();
  }
}