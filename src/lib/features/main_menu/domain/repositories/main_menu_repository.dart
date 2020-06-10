abstract class MainMenuRepository {
  Future<bool> isUserLoggedIn();
  Future<void> logoutUser();
}
