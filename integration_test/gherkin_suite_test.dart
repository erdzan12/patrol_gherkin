import 'package:flutter/widgets.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart'; // notice new import name
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'gherkin/hooks/attach_screenshot_after_step_hook.dart';
import 'package:gherkin/gherkin.dart';

import 'package:patrol_gherkin/main.dart' as app;

import 'gherkin/steps/i_accept_camera_permissions.dart';
part 'gherkin_suite_test.g.dart';

Future<MyWorld> worldCreator(
    TestConfiguration config, NativeAutomator nativeAutomator) async {
  var world = MyWorld(nativeAutomator: nativeAutomator);
  return world;
}

class MyWorld extends FlutterWorld {
  final NativeAutomator nativeAutomator;
  MyWorld({required this.nativeAutomator});
}

@GherkinTestSuite(
  useAbsolutePaths: false,
)
Future<void> main() async {
  final nativeAutomator = NativeAutomator(
      config: const NativeAutomatorConfig(
    packageName: "com.example.patrol_gherkin",
  ));
  nativeAutomator.configure();

  var configuration = FlutterTestConfiguration(
    hooks: [
      AttachScreenshotOnFailedStepHook(),
      AttachScreenshotAfterStepHook(),
    ],
    reporters: [
      StdoutReporter(),
      ProgressReporter()
        ..setWriteLineFn(print)
        ..setWriteFn(print),
      TestRunSummaryReporter()
        ..setWriteLineFn(print)
        ..setWriteFn(print),
      JsonReporter(writeReport: (report, f) async {
        print("--------------------------------------------------");
        print("response: $report");
        print("--------------------------------------------------");

        return Future.value();
      }),
    ],
    defaultTimeout: const Duration(seconds: 20),
    stepDefinitions: [
      iAcceptCameraPermissions,
    ],
    createWorld: (TestConfiguration config) =>
        worldCreator(config, nativeAutomator),
    tagExpression: "@test",
  );

  executeTestSuite(
    configuration: configuration,
    appMainFunction: (World world) async {
      WidgetsFlutterBinding.ensureInitialized();
      TestWidgetsFlutterBinding.ensureInitialized();
      await app.main();
    },
    appLifecyclePumpHandler: (phase, tester) async {},
  );
}
