import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../api_client/api_client.dart';
import 'auth_service.dart';

class CreateUserService {
  final AuthService _authService;
  final ApiClient _apiClient;

  CreateUserService({
    required Locator locator,
    AuthService? authService,
    ApiClient? apiClient,
  })  : _authService = authService ?? locator<AuthService>(),
        _apiClient = apiClient ?? GetIt.I.get<ApiClient>();

  Future<void> createUserAndLogin(String name) async {
    await _apiClient.createUser(name: name);
    _authService.logIn();
  }

  bool isUserValidName(String name) {
    return name.isNotEmpty;
  }
}
