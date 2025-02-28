import 'package:drift/drift.dart';
import 'package:platform_common/src/data/database/core/app_database.dart';

part 'movie_description_dao.g.dart';

@DriftAccessor(tables: [MovieDescriptions])
class MovieDescriptionDao extends DatabaseAccessor<AppDatabase>
    with _$MovieDescriptionDaoMixin {
  MovieDescriptionDao(super.attachedDatabase);

  Future<void> saveMovieDescription(List<MovieDescription> movieDescription) {
    return batch(
      (batch) => batch.insertAll(
        movieDescriptions,
        movieDescription,
        mode: InsertMode.insertOrReplace,
      ),
    );
  }

  Future<void> deleteMovieDescription() async {
    await delete(movieDescriptions).go();
  }

  Future<List<MovieDescription>> getMovieDescription() async {
    return select(movieDescriptions).get();
  }
}

@DataClassName('MovieDescription')
class MovieDescriptions extends Table {
  TextColumn get id => text()();

  TextColumn get description => text().nullable()();
  TextColumn get title => text().nullable()();
  TextColumn get posterPath => text().nullable()();
  TextColumn get releaseDate => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
