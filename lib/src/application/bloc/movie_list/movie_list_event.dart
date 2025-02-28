import 'package:platform_common/src/application/core/base_bloc_event.dart';

class MovieListEvent extends BaseBlocEvent {}

class Init extends MovieListEvent {}

class MoreMovieList extends MovieListEvent {
  int page;
  MoreMovieList(
      this.page,
      );
}
