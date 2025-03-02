import 'package:platform_common/src/application/core/base_bloc_state.dart';

class CreateUserState extends BaseBlocState {
  String? name;
  String? job;
  bool? createStatusSuccess;
  bool? networkFoundStatus;

  CreateUserState({
    this.name,
    this.job,
    this.createStatusSuccess = false,
    this.networkFoundStatus=false,
  });

  @override
  CreateUserState copyWith({
    String? name,
    String? job,
    bool? createStatusSuccess,
    bool? networkFoundStatus,
  }) {
    return CreateUserState(
      name: name ?? this.name,
      job: job ?? this.job,
      createStatusSuccess: createStatusSuccess ?? this.createStatusSuccess,
      networkFoundStatus: networkFoundStatus ?? this.networkFoundStatus,
    )..processState = processState;
  }
}
