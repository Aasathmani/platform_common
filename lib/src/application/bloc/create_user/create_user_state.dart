import 'package:platform_common/src/application/core/base_bloc_state.dart';

class CreateUserState extends BaseBlocState {
  String? name;
  String? job;
  bool? createStatusSuccess;

  CreateUserState({
    this.name,
    this.job,
    this.createStatusSuccess = false,
  });

  @override
  CreateUserState copyWith({
    String? name,
    String? job,
    bool? createStatusSuccess,
  }) {
    return CreateUserState(
      name: name ?? this.name,
      job: job ?? this.job,
      createStatusSuccess: createStatusSuccess ?? this.createStatusSuccess,
    )..processState = processState;
  }
}
