import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_common/src/application/bloc/movie_list/movie_list_bloc.dart';
import 'package:platform_common/src/application/bloc/movie_list/movie_list_event.dart';
import 'package:platform_common/src/application/bloc/movie_list/movie_list_state.dart';
import 'package:platform_common/src/core/app_constants.dart';
import 'package:platform_common/src/data/database/core/app_database.dart';
import 'package:platform_common/src/presentation/core/app_page.dart';
import 'package:platform_common/src/presentation/core/base_state.dart';
import 'package:platform_common/src/presentation/core/theme/colors.dart';
import 'package:platform_common/src/presentation/movie_description/movie_description_page.dart';

class MovieListPage extends StatefulWidget {
  static String route = '/movieListPage';
  const MovieListPage({super.key});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends BaseState<MovieListPage> {
  MovieListBloc? _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = BlocProvider.of<MovieListBloc>(context);
    _bloc!.message.listen((value) => showMessage(value));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieListBloc, MovieListState>(
      listener: (context, state) {},
      builder: (context, state) {
        return AppPage(
          backgroundColor: AppColors.white,
          title: "Movie List",
          retryOnTap: () {},
          processStateStream: _bloc!.stream.map((state) => state.processState),
          key: const Key("movieList"),
          initStateStream: _bloc!.stream.map((state) => state.isInitCompleted),
          child: _body(context, state),
        );
      },
    );
  }

  Widget _body(BuildContext context, MovieListState state) {
    final ScrollController scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (!(_bloc!.state.isFetching ?? true)) {
          _bloc?.add(MoreMovieList(_bloc!.state.page + 1));
        }
      }
    });
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Units.kStandardPadding,
        vertical: Units.kStandardPadding,
      ),
      child: state.movieList!.isNotEmpty
          ? ListView.builder(
              controller: scrollController,
              itemCount: state.movieList!.length,
              itemBuilder: (context, index) {
                if (index == state.movieList!.length) {
                  return state.isFetching == true
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const SizedBox.shrink();
                }
                final item = state.movieList![index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(
                    horizontal: Units.kMPadding,
                    vertical: Units.kSPadding,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Units.kStandardPadding,
                      vertical: Units.kStandardPadding,
                    ),
                    child: _getMovieListData(context, state, item),
                  ),
                );
              },
            )
          : const Center(
              child: Text("No data"),
            ),
    );
  }

  Widget _getMovieListData(
    BuildContext context,
    MovieListState state,
    MovieList item,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.network(
              "http://image.tmdb.org/t/p/w185/${item.posterPath}",
              height: 100,
              width: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(left: Units.kStandardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150,
                    child: Text(
                      "Movie: ${item.title!}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text("Release Date: ${item.releaseDate!}"),
                ],
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              MovieDescriptionPage.route,
              arguments: MovieDescriptionArgument(item.id),
            );
          },
          icon: const Icon(
            Icons.arrow_forward,
            size: 20,
          ),
        ),
      ],
    );
  }
}

class MovieDescriptionArgument {
  String? id;

  MovieDescriptionArgument(this.id);
}
