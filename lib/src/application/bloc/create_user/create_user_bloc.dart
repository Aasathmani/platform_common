import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_common/src/application/bloc/create_user/create_user_event.dart';
import 'package:platform_common/src/application/bloc/create_user/create_user_state.dart';
import 'package:platform_common/src/application/core/base_bloc.dart';
import 'package:platform_common/src/application/core/process_state.dart';
import 'package:platform_common/src/data/user_list/user_list_repository.dart';
import 'package:platform_common/src/utils/regex_util.dart';
import 'package:platform_common/src/utils/string_utils.dart';

class CreateUserBloc
    extends BaseBloc<CreateUserEvent, CreateUserState, CreateUserUIEvent> {
  final UserListRepository userListRepository;
  CreateUserBloc({
    required this.userListRepository,
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
      final data = {"name": state.name, "job": state.job};
      final result = await userListRepository.getCreateUser(data);
      if (result == true) {
        emit(state.copyWith(createStatusSuccess: true)
          ..processState = ProcessState.completed(),);
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
