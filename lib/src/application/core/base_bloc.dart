import 'package:bloc/bloc.dart';
import 'package:platform_common/src/application/core/base_bloc_event.dart';
import 'package:platform_common/src/application/core/base_bloc_state.dart';
import 'package:platform_common/src/utils/string_utils.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc<
    Event extends BaseBlocEvent,
    State extends BaseBlocState,
    UIEvent extends BaseUIEvent> extends Bloc<Event, State> {
  final _event = PublishSubject<UIEvent>();
  final _message = PublishSubject<String>();
  final _dialogMessage = PublishSubject<String>();
  final _noNetworkError = PublishSubject<void>();
  bool _isDisposed = false;

  BaseBloc(super.initialState);

  Stream<UIEvent> get eventStream => _event;

  UIEvent get getEvent;

  void publish(UIEvent event) {
    if (!_event.isClosed) _event.add(event);
  }

  Stream<String> get message => _message;

  Stream<String> get dialogMessage => _dialogMessage;

  void showMessage(String? message) {
    if (!_message.isClosed && StringUtils.isNotNullAndEmpty(message)) {
      _message.add(message!);
    }
  }

  void showMessageDialog(String? message) {
    if (!_dialogMessage.isClosed && StringUtils.isNotNullAndEmpty(message)) {
      _dialogMessage.add(message!);
    }
  }

  Stream<void> get noNetworkError => _noNetworkError;

  bool get isDisposed => _isDisposed;

  void dispose() {
    _event.close();
    _message.close();
    _dialogMessage.close();
    _noNetworkError.close();
    _isDisposed = true;
  }
}

abstract class BaseUIEvent {}
