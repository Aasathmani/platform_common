import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_common/src/application/bloc/movie_description/movie_description_bloc.dart';
import 'package:platform_common/src/application/bloc/movie_description/movie_description_state.dart';
import 'package:platform_common/src/core/app_constants.dart';
import 'package:platform_common/src/data/database/core/app_database.dart';
import 'package:platform_common/src/presentation/core/app_page.dart';
import 'package:platform_common/src/presentation/core/base_state.dart';
import 'package:platform_common/src/presentation/core/theme/colors.dart';
import 'package:platform_common/src/presentation/core/theme/text_styles.dart';

class MovieDescriptionPage extends StatefulWidget {
  static const route = '/movieDescription';
  const MovieDescriptionPage({super.key});

  @override
  State<MovieDescriptionPage> createState() => _MovieDescriptionPageState();
}

class _MovieDescriptionPageState extends BaseState<MovieDescriptionPage> {
  MovieDescriptionBloc? _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = BlocProvider.of<MovieDescriptionBloc>(context);
    _bloc!.message.listen((value) => showMessage(value));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieDescriptionBloc, MovieDescriptionState>(
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

  Widget _body(BuildContext context, MovieDescriptionState state) {
    MovieDescription? item;
    if (state.movieDescription!.isNotEmpty) {
      item = state.movieDescription!.first;
    }

    return item == null
        ? const Center(
            child: Text("No data"),
          )
        : SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Movie Poster
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "http://image.tmdb.org/t/p/w500${item.posterPath}",
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        const BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _infoRow(context, "Movie Name:", item.title!),
                        const SizedBox(height: 8),
                        _infoRow(context, "Description:", item.description!),
                        const SizedBox(height: 8),
                        _infoRow(context, "Release Date:", item.releaseDate!),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

// Helper Widget for Consistent Layout
  Widget _infoRow(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120, // Fixed width for labels
          child: Text(
            label,
            style: TextStyles.body1Bold(context),
          ),
        ),
        Expanded(
          child: Text(
            value,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
