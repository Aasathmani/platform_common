import 'package:platform_common/src/data/database/core/app_database.dart';
import 'package:platform_common/src/data/database/movie_description/movie_description_dao.dart';
import 'package:platform_common/src/data/movie_description/movie_description_service.dart';
import 'package:platform_common/src/utils/guard.dart';

class MovieDescriptionRepository {
  static MovieDescriptionRepository? instance;
  final MovieDescriptionService movieDescriptionService;
  final MovieDescriptionDao movieDescriptionDao;

  MovieDescriptionRepository({
    required this.movieDescriptionService,
    required this.movieDescriptionDao,
  });

  Future<List<MovieDescription>?>? getMovieDescription(String page) async {
    await Guard.asNullableAsync(() async {
      final dataFromResponse =
          await movieDescriptionService.fetchMovieDescription(page);

      if (dataFromResponse.isNotEmpty) {
        final userList = dataFromResponse
            .map((item) => _toMovieList(item))
            .nonNulls
            .toList();
        await movieDescriptionDao.deleteMovieDescription();
        await movieDescriptionDao.saveMovieDescription(userList);
      }
    });
    return movieDescriptionDao.getMovieDescription();
  }
}

MovieDescription? _toMovieList(Map<String, dynamic> item) {
  return Guard.asNullable<MovieDescription>(() {
    return MovieDescription(
      id: item['id'].toString(),
      description: item['overview'].toString(),
      title: item['title'].toString(),
      posterPath: item['poster_path'].toString(),
      releaseDate: item['release_date'].toString(),
    );
  });
}
