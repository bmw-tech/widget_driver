/// Extend this class when you need to provide a TestDefault implementation for a given type.
///
/// Say for example that you have some service called `AuthService` which might look something like this:
///
/// ```dart
/// class AuthService {
///     bool get isLoggedIn => ...
///
///     void logout() { ... }
/// }
/// ```
///
/// If you want to create a version of this service with no real code which you can use in your testDriver
/// you have to create some class which implements this interface.
/// Now if you just create some class which implements the `AuthService`
/// then you are also forced to override the complete interface of the `AuthService`.
///
/// To get around this you can just extend the [EmptyDefault]. This way you are not force to override any interface.
/// And if you want/need a default implementation for a given interface, then you can just choose to implement that.
/// Like so:
///
/// ```dart
/// class TestDefaultAuthService extends EmptyDefault implements AuthService {}
/// ```
abstract class EmptyDefault {
  const EmptyDefault();

  @override
  dynamic noSuchMethod(Invocation invocation) {}
}
