import 'package:platform_common/src/application/core/base_bloc_state.dart';
import 'package:platform_common/src/data/database/core/app_database.dart';

class MovieListState extends BaseBlocState {
  List<MovieList>? movieList;
  int page;
  bool? isFetching;

  MovieListState({
    this.page = 1,
    this.movieList = const <MovieList>[],
    this.isFetching = false,
  });

  @override
  MovieListState copyWith({
    List<MovieList>? movieList,
    int? page,
    bool? isFetching,
  }) {
    return MovieListState(
      movieList: movieList ?? this.movieList,
      page: page ?? this.page,
      isFetching: isFetching ?? this.isFetching,
    )..processState = processState;
  }
}
