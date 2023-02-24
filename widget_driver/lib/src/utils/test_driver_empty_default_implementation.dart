/// Extend this class for TestDriverDefaultValues that you don't want to implement
abstract class TestDriverEmptyDefaultImplementation {
  const TestDriverEmptyDefaultImplementation();

  @override
  dynamic noSuchMethod(Invocation invocation) {}
}
