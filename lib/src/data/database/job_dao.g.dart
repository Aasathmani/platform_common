// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_dao.dart';

// ignore_for_file: type=lint
mixin _$JobDaoMixin on DatabaseAccessor<AppDatabase> {
  $JobsTable get jobs => attachedDatabase.jobs;
  Future<int> deleteJobById(String jobId) {
    return customUpdate(
      'DELETE FROM jobs WHERE id = ?1',
      variables: [Variable<String>(jobId)],
      updates: {jobs},
      updateKind: UpdateKind.delete,
    );
  }

  Future<int> deleteJobByType(String type) {
    return customUpdate(
      'DELETE FROM jobs WHERE type = ?1',
      variables: [Variable<String>(type)],
      updates: {jobs},
      updateKind: UpdateKind.delete,
    );
  }

  Future<int> updateJobStatus(String status, String jobId) {
    return customUpdate(
      'UPDATE jobs SET status = ?1 WHERE id = ?2',
      variables: [Variable<String>(status), Variable<String>(jobId)],
      updates: {jobs},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> markJobFailed(String jobId) {
    return customUpdate(
      'UPDATE jobs SET status = \'failed\', failure_count = failure_count + 1 WHERE id = ?1',
      variables: [Variable<String>(jobId)],
      updates: {jobs},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> markFailedJobsAsPending() {
    return customUpdate(
      'UPDATE jobs SET status = \'pending\' WHERE status = \'failed\'',
      variables: [],
      updates: {jobs},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> updateAllJobsStatus(String status) {
    return customUpdate(
      'UPDATE jobs SET status = ?1',
      variables: [Variable<String>(status)],
      updates: {jobs},
      updateKind: UpdateKind.update,
    );
  }
}
