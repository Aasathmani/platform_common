import 'dart:async';

import 'package:platform_common/config.dart';
import 'package:platform_common/src/core/app.dart';

Future<void> main() async {
  Config.appFlavor = Staging();
  await initApp();
}
