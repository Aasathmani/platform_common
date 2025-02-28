import 'package:platform_common/src/application/core/base_bloc_state.dart';
import 'package:platform_common/src/data/database/core/app_database.dart';

class UserListState extends BaseBlocState {
  List<UserList>? userList;
  int page;
  bool? isFetching;

  UserListState({
    this.userList = const <UserList>[],
    this.page = 1,
    this.isFetching=false,
  });

  @override
  UserListState copyWith({
    List<UserList>? userList,
    int? page,
    bool? isFetching,
  }) {
    return UserListState(
      userList: userList ?? this.userList,
      page: page ?? this.page,
        isFetching: isFetching ?? this.isFetching,
    )..processState = processState;
  }
}
