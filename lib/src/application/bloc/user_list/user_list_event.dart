import 'package:platform_common/src/application/core/base_bloc_event.dart';

class UserListEvent extends BaseBlocEvent {}

class Init extends UserListEvent {}

class MoreUserList extends UserListEvent {
  int page;
  MoreUserList(
    this.page,
  );
}
