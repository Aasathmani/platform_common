import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_common/src/application/bloc/user_list/user_list_event.dart';
import 'package:platform_common/src/application/bloc/user_list/user_list_state.dart';
import 'package:platform_common/src/application/core/base_bloc.dart';
import 'package:platform_common/src/application/core/process_state.dart';
import 'package:platform_common/src/data/user_list/user_list_repository.dart';

class UserListBloc
    extends BaseBloc<UserListEvent, UserListState, UserListUiEvent> {
  final UserListRepository userListRepository;
  UserListBloc({
    required this.userListRepository,
}) : super(UserListState()) {
    on<Init>((event, emit) async {
      await initialize(event: event, emit: emit);
    });
    add(Init());
  }

  Future<void> initialize({
    required Init event,
    required Emitter<UserListState> emit,
  }) async {
    emit(state.copyWith()..processState=ProcessState.busy());
    try {
      final userList = await userListRepository.getUserList();
      emit(state.copyWith(userList: userList)..processState=ProcessState.completed());
    }
    catch(e){
      showMessage(e.toString());
      emit(state.copyWith()..processState=ProcessState.completed());
    }
  }

  @override
  UserListUiEvent get getEvent => throw UserListUiEvent();
}

class UserListUiEvent extends BaseUIEvent {}
