import 'package:image_picker/image_picker.dart';
import 'package:platform_common/src/application/bloc/movie_description/movie_description_bloc.dart';
import 'package:platform_common/src/application/bloc/movie_list/movie_list_bloc.dart';
import 'package:platform_common/src/application/bloc/splash/splash_bloc.dart';
import 'package:platform_common/src/application/bloc/user_list/user_list_bloc.dart';
import 'package:platform_common/src/application/bloc/web_view/web_view_bloc.dart';
import 'package:platform_common/src/data/core/repository_provider.dart';
import 'package:platform_common/src/presentation/movie_list/movie_list_page.dart';
import 'package:platform_common/src/presentation/web_view/web_view_page.dart';
import 'package:platform_common/src/utils/device_token_helper.dart';
import 'package:platform_common/src/utils/file_util.dart';
import 'package:platform_common/src/utils/notification_util.dart';

SplashBloc provideSplashBloc() {
  return SplashBloc(
    authRepository: provideAuthRepository(),
    userRepository: provideUserRepository(),
  );
}

UserListBloc provideUserListBloc() {
  return UserListBloc(
    userListRepository: provideUserListRepository(),
  );
}

MovieListBloc provideMovieListBloc() {
  return MovieListBloc(
    movieListRepository: provideMovieListRepository(),
  );
}

WebViewBloc provideWebViewBloc(WebViewArgument argument) {
  return WebViewBloc(
    authRepository: provideAuthRepository(),
    isHeaderRequired: argument.isHeaderRequired,
    url: argument.url,
    title: argument.title,
    successUrl: argument.successUrl,
    alternateSuccessUrlList: argument.alternateSuccessUrlList,
    failureUrl: argument.failureUrl,
    isBackConfirmationRequired: argument.isBackConfirmationRequired,
    fileUtil: provideFileUtil(),
  );
}

MovieDescriptionBloc provideMovieDescriptionBloc(
  MovieDescriptionArgument argument,
) {
  return MovieDescriptionBloc(
    movieId: argument.id!, movieDescriptionRepository: provideMovieDescriptionRepository(),
  );
}

DeviceTokenHelper provideDeviceTokenHelper() {
  return DeviceTokenHelper(
    deviceTokenRepository: provideDeviceTokenRepository(),
    userRepository: provideUserRepository(),
  );
}

NotificationUtil provideNotificationUtil() {
  return NotificationUtil(
    networkValidator: provideNetworkValidator(),
  );
}

FileUtil provideFileUtil() {
  return FileUtil(
    imagePicker: ImagePicker(),
  );
}
