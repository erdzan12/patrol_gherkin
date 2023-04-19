import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gherkin/gherkin.dart';

import '../../gherkin_suite_test.dart';

final iAcceptCameraPermissions = then<MyWorld>(
  'I tap accept camera permissions',
  (context) async {
    try {
      await context.world.nativeAutomator.grantPermissionWhenInUse();
    } catch (e) {
      debugPrint(e.toString());
    }

    return Future.value();
  },
);
