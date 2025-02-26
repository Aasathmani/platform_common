import 'package:platform_common/src/application/core/base_bloc_state.dart';
import 'package:platform_common/src/data/database/core/app_database.dart';

class UserListState extends BaseBlocState {
  List<UserList>? userList;

  UserListState({
    this.userList = const <UserList>[],
  });

  @override
  UserListState copyWith({
    List<UserList>? userList,
  }) {
    return UserListState(
      userList: userList ?? this.userList,
    )..processState = processState;
  }
}
