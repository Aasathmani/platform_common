import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_common/src/application/bloc/movie_description/movie_description_event.dart';
import 'package:platform_common/src/application/bloc/movie_description/movie_description_state.dart';
import 'package:platform_common/src/application/core/base_bloc.dart';
import 'package:platform_common/src/application/core/process_state.dart';
import 'package:platform_common/src/data/movie_description/movie_description_repository.dart';

class MovieDescriptionBloc extends BaseBloc<MovieDescriptionEvent,
    MovieDescriptionState, MovieDescriptionUIEvent> {
  String movieId;
  final MovieDescriptionRepository movieDescriptionRepository;
  MovieDescriptionBloc({
    required this.movieId,
    required this.movieDescriptionRepository,
  }) : super(MovieDescriptionState()) {
    on<Init>((event, emit) async {
      await initialize(event: event, emit: emit);
    });
    add(Init());
  }
  @override
  MovieDescriptionUIEvent get getEvent => MovieDescriptionUIEvent();

  Future<void> initialize({
    required Init event,
    required Emitter<MovieDescriptionState> emit,
  }) async {
    emit(state.copyWith()..processState = ProcessState.busy());
    try {
      final movieList =
          await movieDescriptionRepository.getMovieDescription(movieId);
      emit(
        state.copyWith(movieDescription: movieList)
          ..processState = ProcessState.completed(),
      );
    } catch (e) {
      showMessage(e.toString());
      emit(state.copyWith()..processState = ProcessState.completed());
    }
  }
}

class MovieDescriptionUIEvent extends BaseUIEvent {}
