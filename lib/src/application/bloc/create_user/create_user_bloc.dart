import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_common/src/application/bloc/create_user/create_user_event.dart';
import 'package:platform_common/src/application/bloc/create_user/create_user_state.dart';
import 'package:platform_common/src/application/core/base_bloc.dart';
import 'package:platform_common/src/application/core/process_state.dart';
import 'package:platform_common/src/data/user_list/user_list_repository.dart';
import 'package:platform_common/src/utils/string_utils.dart';
import 'package:rxdart/rxdart.dart';

class CreateUserBloc
    extends BaseBloc<CreateUserEvent, CreateUserState, CreateUserUIEvent> {
  final UserListRepository userListRepository;
  final Connectivity connectivity;

  final _subscriptions = CompositeSubscription();

  CreateUserBloc({
    required this.userListRepository,
    required this.connectivity,
  }) : super(CreateUserState()) {
    on<CreateUserTapped>((event, emit) async {
      await _getCreateUser(event: event, emit: emit);
    });
    on<JobTextChanged>((event, emit) {
      emit(state.copyWith(job: event.job));
    });
    on<NameFieldChanged>((event, emit) {
      emit(state.copyWith(name: event.name));
    });

    on<NetworkFound>((event, emit) async {
      connectivity.onConnectivityChanged.listen((result) {
        ///Obtained list will contain ConnectivityResult.none only when there is no connectivity.
        if (!result.contains(ConnectivityResult.none)) {
          emit(state.copyWith(networkFoundStatus: true));
        } else {
          emit(state.copyWith(networkFoundStatus: false));
        }
      });
    });
    _subscriptions.add(
      connectivity.onConnectivityChanged.listen((result) {
        ///Obtained list will contain ConnectivityResult.none only when there is no connectivity.
        if (!result.contains(ConnectivityResult.none)) {
          add(NetworkFound());
        }
      }),
    );
    add(NetworkFound());
  }

  Future<void> checkInitialConnection() async {
    final result = await connectivity.checkConnectivity();
    if (!result.contains(ConnectivityResult.none)) {
      emit(state.copyWith(networkFoundStatus: true));
    }
  }

  @override
  CreateUserUIEvent get getEvent => CreateUserUIEvent();

  Future<void> _getCreateUser({
    required CreateUserTapped event,
    required Emitter<CreateUserState> emit,
  }) async {
    if (!_isValid(emit)) {
      return;
    }
    emit(state.copyWith()..processState = ProcessState.busy());
    try {
      final result = await userListRepository.getCreateUser(
        state.name,
        state.job,
        state.networkFoundStatus!,
      );
      if (result == true) {
        if (state.networkFoundStatus == false) {
          showMessage(
            "You are offline, once internet back the user created automatically",
          );
        } else {
          showMessage("The user created successful");
        }
        emit(
          state.copyWith(createStatusSuccess: true)
            ..processState = ProcessState.completed(),
        );
      } else {
        showMessage("User creation failed");
        emit(state.copyWith()..processState = ProcessState.completed());
      }
    } catch (e) {
      showMessage(e.toString());
      emit(state.copyWith()..processState = ProcessState.completed());
    }
  }

  bool _isValid(Emitter<CreateUserState> emit) {
    bool isValid = true;

    if (StringUtils.isNullOrEmpty(state.name)) {
      showMessage("Name field is empty");
      isValid = false;
    } else if (StringUtils.isNullOrEmpty(state.job)) {
      showMessage("Job field is invalid");
      isValid = false;
    }

    return isValid;
  }
}

class CreateUserUIEvent extends BaseUIEvent {}
