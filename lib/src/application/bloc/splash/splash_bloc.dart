import 'package:platform_common/src/application/bloc/splash/splash_event.dart';
import 'package:platform_common/src/application/bloc/splash/splash_state.dart';
import 'package:platform_common/src/application/core/base_bloc.dart';
import 'package:platform_common/src/data/auth/auth_repository.dart';
import 'package:platform_common/src/data/auth/user_repository.dart';

class SplashBloc extends BaseBloc<SplashEvent, SplashState, SplashUIEvent> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  SplashBloc({required this.authRepository, required this.userRepository})
      : super(SplashState()) {
    on<RedirectPage>(
      (event, emit) async {
        final authToken = await authRepository.getActiveToken();
        final user = await userRepository.getCurrentUser();
        await Future.delayed(const Duration(milliseconds: 2000), () {});
        if (user != null && authToken != null) {
          emit(state.copyWith(redirectToOtp: true));
        } else {
          await authRepository.signOut();
          emit(state.copyWith(redirectToLogin: true));
        }
      },
    );
  }

  @override
  SplashUIEvent get getEvent => SplashUIEvent();
}

class SplashUIEvent extends BaseUIEvent {}
