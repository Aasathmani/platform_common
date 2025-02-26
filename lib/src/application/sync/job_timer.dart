import 'dart:async';

import 'package:platform_common/src/application/sync/job_manager.dart';

/// Created by Jemsheer K D on 21 February, 2025.
/// File Name : job_timer
/// Project : Maridock
///
class JobTimer {
  JobTimer._();

  static JobTimer? instance;
  late JobManager _jobManager;

  factory JobTimer.init({required JobManager jobManager}) {
    instance = JobTimer._();
    instance!._jobManager = jobManager;
    return instance!;
  }

  Timer? timer;

  Future<void> startTimer(
    bool isSessionActive, {
    int repeatInterval = 60,
  }) async {
    if (isSessionActive) {
      timer ??= Timer.periodic(
        Duration(seconds: repeatInterval),
        (_) {
          _jobManager.sync();
        },
      );
    }
  }

  void stopTimer() {
    timer?.cancel();
    timer = null;
  }
}
