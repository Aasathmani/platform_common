import 'dart:async';

import 'package:platform_common/src/application/sync/job_manager.dart';
import 'package:platform_common/src/core/exceptions.dart';
import 'package:platform_common/src/data/core/sync/job_repository.dart';
import 'package:platform_common/src/data/database/core/app_database.dart';
import 'package:platform_common/src/data/database/job_dao.dart';
import 'package:uuid/uuid.dart';

/// Created by Jemsheer K D on 24 February, 2025.
/// File Name : job_util
/// Project : FlutterBase
class JobUtils {
  final JobRepository jobRepository;
  final JobManager jobManager;

  static JobUtils? instance;

  JobUtils({
    required this.jobRepository,
    required this.jobManager,
  });

  Future<void> validateNoPendingJob(String type, String userId) async {
    final job = await jobRepository.getJobByType(type, userId);
    if (job != null) {
      throw PendingJobException();
    }
  }

  Future<List<Job>> getPendingJobListByType(String type, String userId) async {
    return jobRepository.getJobListByType(type, userId);
  }

  Future<bool> scheduleJob(
    String type,
    String recordId, {
    int priority = Priority.medium,
    String status = JobStatus.pending,
  }) async {
    final job = await jobRepository.getJob(type, recordId);
    if (job != null) {
      await jobRepository.deleteJobById(job.id);
    }
    await jobRepository.createSyncJob(
      Job(
        id: const Uuid().v1(),
        type: type,
        recordId: recordId,
        priority: priority,
        failureCount: 0,
        status: status,
      ),
    );
    final _ = jobManager.sync();
    return true;
  }
}
