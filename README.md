# patrol_gherkin

To generate the test suite based on the gherkin features use:

    flutter pub run build_runner watch --delete-conflicting-outputs

To run the tests use:

    patrol test --target integration_test/gherkin_suite_test.dart
