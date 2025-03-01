import 'package:platform_common/src/data/database/core/app_database.dart';
import 'package:platform_common/src/data/database/movie_list/movie_list_dao.dart';
import 'package:platform_common/src/data/movie_list/movie_list_service.dart';
import 'package:platform_common/src/utils/extensions.dart';
import 'package:platform_common/src/utils/guard.dart';

class MovieListRepository {
  static MovieListRepository? instance;
  final MovieListService movieListService;
  final MovieListDao movieListDao;

  MovieListRepository({
    required this.movieListService,
    required this.movieListDao,
  });

  Future<List<MovieList>?>? getMovieList(int page) async {
    await Guard.asNullableAsync(() async {
      final dataFromResponse = await movieListService.fetchMovieList(page);

      if (dataFromResponse.isNotEmpty) {
        final userList = toGenericMapList(dataFromResponse['results'])
            .map((item) => _toMovieList(item))
            .nonNulls
            .toList();
        await movieListDao.deleteProjectLists();
        await movieListDao.saveProjectLists(userList);
      }
    });
    return movieListDao.getBaitCategoryList();
  }
}

MovieList? _toMovieList(Map<String, dynamic> item) {
  return Guard.asNullable<MovieList>(() {
    return MovieList(
      id: item['id'].toString(),
      backdropPath: item['backdrop_path'].toString(),
      title: item['title'].toString(),
      posterPath: item['poster_path'].toString(),
      releaseDate: item['release_date'].toString(),
    );
  });
}
