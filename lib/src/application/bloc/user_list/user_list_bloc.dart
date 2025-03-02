import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_common/src/application/bloc/user_list/user_list_event.dart';
import 'package:platform_common/src/application/bloc/user_list/user_list_state.dart';
import 'package:platform_common/src/application/core/base_bloc.dart';
import 'package:platform_common/src/application/core/process_state.dart';
import 'package:platform_common/src/application/sync/job_connectivity.dart';
import 'package:platform_common/src/data/core/sync/job_repository.dart';
import 'package:platform_common/src/data/user_list/user_list_repository.dart';
import 'package:rxdart/rxdart.dart';

class UserListBloc
    extends BaseBloc<UserListEvent, UserListState, UserListUiEvent> {
  final UserListRepository userListRepository;
  final JobConnectivity jobConnectivity;
  final JobRepository jobRepository;
  final Connectivity connectivity;

  final _subscriptions = CompositeSubscription();

  UserListBloc({
    required this.userListRepository,
    required this.jobConnectivity,
    required this.connectivity,
    required this.jobRepository,
  }) : super(UserListState()) {
    on<Init>((event, emit) async {
      await initialize(event: event, emit: emit);
    });
    add(Init());
    on<MoreUserList>((event, emit) async {
      await getMoreListUser(event: event, emit: emit);
    });
    on<NetworkFound>((event, emit) async {
      emit(state.copyWith(networkFoundStatus: true));
      if (await jobRepository.getRemainingJobCount() > 0) {
        jobConnectivity.init();
      }
    });
    _subscriptions.add(
      connectivity.onConnectivityChanged.listen((result) {
        ///Obtained list will contain ConnectivityResult.none only when there is no connectivity.
        if (!result.contains(ConnectivityResult.none)) {
          add(NetworkFound());
        } else {
          jobConnectivity.stopTimer();
        }
      }),
    );
  }

  Future<void> initialize({
    required Init event,
    required Emitter<UserListState> emit,
  }) async {
    emit(state.copyWith()..processState = ProcessState.busy());
    try {
      final userList = await userListRepository.getUserList(state.page);
      emit(
        state.copyWith(userList: userList)
          ..processState = ProcessState.completed(),
      );
    } catch (e) {
      showMessage(e.toString());
      emit(state.copyWith()..processState = ProcessState.completed());
    }
  }

  Future<void> getMoreListUser({
    required MoreUserList event,
    required Emitter<UserListState> emit,
  }) async {
    if (state.isFetching!) return;
    emit(state.copyWith(isFetching: true, page: event.page));
    final userList = await userListRepository.getUserList(state.page);
    emit(
      state.copyWith(
        userList: [...?state.userList, ...?userList],
        isFetching: false,
      ),
    );
  }

  @override
  UserListUiEvent get getEvent => throw UserListUiEvent();
}

class UserListUiEvent extends BaseUIEvent {}
