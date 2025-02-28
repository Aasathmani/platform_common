import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_common/src/application/bloc/movie_list/movie_list_event.dart';
import 'package:platform_common/src/application/bloc/movie_list/movie_list_state.dart';
import 'package:platform_common/src/application/core/base_bloc.dart';
import 'package:platform_common/src/application/core/process_state.dart';
import 'package:platform_common/src/data/movie_list/movie_list_repository.dart';

class MovieListBloc
    extends BaseBloc<MovieListEvent, MovieListState, MovieListUIEvent> {
  final MovieListRepository movieListRepository;
  MovieListBloc({
    required this.movieListRepository,
  }) : super(MovieListState()) {
    on<Init>((event, emit) async {
      await initialize(event: event, emit: emit);
    });
    on<MoreMovieList>((event, emit) async {
      await getMoreMovieUser(event: event, emit: emit);
    });
    add(Init());
  }

  @override
  MovieListUIEvent get getEvent => MovieListUIEvent();

  Future<void> initialize({
    required Init event,
    required Emitter<MovieListState> emit,
  }) async {
    emit(state.copyWith()..processState = ProcessState.busy());
    try {
      final movieList = await movieListRepository.getMovieList(state.page);
      emit(
        state.copyWith(movieList: movieList)
          ..processState = ProcessState.completed(),
      );
    } catch (e) {
      showMessage(e.toString());
      emit(state.copyWith()..processState = ProcessState.completed());
    }
  }

  Future<void> getMoreMovieUser({
    required MoreMovieList event,
    required Emitter<MovieListState> emit,
  }) async {
    if (state.isFetching!) return;
    emit(state.copyWith(isFetching: true, page: event.page));
    final movieList = await movieListRepository.getMovieList(state.page);
    emit(
      state.copyWith(
        movieList: [...?state.movieList, ...?movieList],
        isFetching: false,
      ),
    );
  }
}

class MovieListUIEvent extends BaseUIEvent {}
