class ApiClient {
  Future<void> createUser({required String name}) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
