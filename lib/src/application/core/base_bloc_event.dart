import 'package:platform_common/src/application/core/process_state.dart';

abstract class BaseBlocEvent {
  ProcessState processState = ProcessState.initial();
}
