import 'package:platform_common/src/application/core/base_bloc_state.dart';
import 'package:platform_common/src/data/database/core/app_database.dart';

class UserListState extends BaseBlocState {
  List<UserList>? userList;
  int page;
  bool? isFetching;
  bool? networkFoundStatus;

  UserListState({
    this.userList = const <UserList>[],
    this.page = 1,
    this.isFetching = false,
    this.networkFoundStatus = false,
  });

  @override
  UserListState copyWith({
    List<UserList>? userList,
    int? page,
    bool? isFetching,
    bool? networkFoundStatus,
  }) {
    return UserListState(
      userList: userList ?? this.userList,
      page: page ?? this.page,
      isFetching: isFetching ?? this.isFetching,
      networkFoundStatus: networkFoundStatus ?? this.networkFoundStatus,
    )..processState = processState;
  }
}
