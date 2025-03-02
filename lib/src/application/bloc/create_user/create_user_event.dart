import 'package:platform_common/src/application/core/base_bloc_event.dart';

class CreateUserEvent extends BaseBlocEvent {}

class CreateUserTapped extends CreateUserEvent {}

class NameFieldChanged extends CreateUserEvent {
  String name;
  NameFieldChanged(this.name);
}

class JobTextChanged extends CreateUserEvent {
  String job;
  JobTextChanged(this.job);
}

class NetworkFound extends CreateUserEvent {
  NetworkFound();
}
