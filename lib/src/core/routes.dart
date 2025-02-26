import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_common/src/application/bloc/web_view/web_view_bloc.dart';
import 'package:platform_common/src/application/core/bloc_provider.dart';
import 'package:platform_common/src/presentation/splash/splash_page.dart';
import 'package:platform_common/src/presentation/user_list/user_list_page.dart';
import 'package:platform_common/src/presentation/web_view/web_view_page.dart';

final Map<String, Widget Function(BuildContext context)> routes = {
  SplashPage.route: (_) => BlocProvider(
        create: (_) => provideSplashBloc(),
        child: const SplashPage(),
      ),
  UserListPage.route: (_) => BlocProvider(create: (_)=> provideUserListBloc(),
  child: const UserListPage(),
  )
/*  LoginPage.route: (_) => BlocProvider(
    create: (_) => provideLoginBloc(),
    child: const LoginPage(),
  ),*/
};

Route<dynamic>? generatedRoutes(RouteSettings settings) {
  final uri = Uri.parse(settings.name ?? '');
  debugPrint("URI.PATH : ${uri.path}");
  debugPrint("URI.queryParams : ${uri.queryParameters}");
  debugPrint("Settings : ${settings.name}");
  debugPrint("Arguments :  ${settings.arguments ?? "null"}");

  switch (uri.path) {
    case WebViewPage.route:
      if (settings.arguments != null && settings.arguments is WebViewArgument) {
        return _getWebViewRoute(
          settings,
          settings.arguments! as WebViewArgument,
        );
      }
  }
  return null;
}

MaterialPageRoute _getWebViewRoute(
  RouteSettings settings,
  WebViewArgument argument,
) {
  return MaterialPageRoute(
    builder: (context) => BlocProvider<WebViewBloc>(
      create: (context) => provideWebViewBloc(argument),
      child: const WebViewPage(),
    ),
    settings: settings,
  );
}
