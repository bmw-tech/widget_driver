/// Extend this class for TestDriverDefaultValues that you don't want to implement
abstract class EmptyDefault {
  const EmptyDefault();

  @override
  dynamic noSuchMethod(Invocation invocation) {}
}
