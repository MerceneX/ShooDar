import 'package:shoodar/core/usecases/usecase.dart';
import 'package:shoodar/features/main_menu/domain/repositories/main_menu_repository.dart';

class LogoutUser implements UseCase<void, NoParams> {
  final MainMenuRepository repository;

  LogoutUser(this.repository);

  @override
  Future<void> call(NoParams params) async {
    return await repository.logoutUser();
  }
}