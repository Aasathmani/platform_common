import 'package:platform_common/src/application/core/base_bloc_state.dart';
import 'package:platform_common/src/data/database/core/app_database.dart';

class MovieDescriptionState extends BaseBlocState {
  List<MovieDescription>? movieDescription;

  MovieDescriptionState({
    this.movieDescription = const <MovieDescription>[],
  });

  @override
  MovieDescriptionState copyWith({
    List<MovieDescription>? movieDescription,
  }) {
    return MovieDescriptionState(
      movieDescription: movieDescription ?? this.movieDescription,
    )..processState = processState;
  }
}
