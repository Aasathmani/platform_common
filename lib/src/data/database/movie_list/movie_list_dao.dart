import 'package:drift/drift.dart';
import 'package:platform_common/src/data/database/core/app_database.dart';

part 'movie_list_dao.g.dart';

@DriftAccessor(tables: [MovieLists])
class MovieListDao extends DatabaseAccessor<AppDatabase>
    with _$MovieListDaoMixin {
  MovieListDao(super.attachedDatabase);

  Future<void> saveProjectLists(List<MovieList> movieList) {
    return batch(
      (batch) => batch.insertAll(
        movieLists,
        movieList,
        mode: InsertMode.insertOrReplace,
      ),
    );
  }

  Future<void> deleteProjectLists() async {
    await delete(movieLists).go();
  }

  Future<List<MovieList>> getBaitCategoryList() async {
    return select(movieLists).get();
  }
}

@DataClassName('MovieList')
class MovieLists extends Table {
  TextColumn get id => text()();

  TextColumn get backdropPath => text().nullable()();
  TextColumn get title => text().nullable()();
  TextColumn get posterPath => text().nullable()();
  TextColumn get releaseDate => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
