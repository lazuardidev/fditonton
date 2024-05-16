import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/tvseries/tvseries_table.dart';

abstract class TVSeriesLocalDataSource {
  Future<String> insertTVSeriesToWatchList(TVSeriesTable tv);
  Future<String> removeTVSeriesFromWatchList(TVSeriesTable tv);
  Future<TVSeriesTable?> getTVSeriesById(int id);
  Future<List<TVSeriesTable>> getWatchListTVSeries();
}

class TVSeriesLocalDataSourceImpl implements TVSeriesLocalDataSource {
  final DatabaseHelper databaseHelper;

  TVSeriesLocalDataSourceImpl({
    required this.databaseHelper,
  });

  @override
  Future<List<TVSeriesTable>> getWatchListTVSeries() async {
    final result = await databaseHelper.getWatchlistTVSeries();
    return result.map((data) => TVSeriesTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertTVSeriesToWatchList(TVSeriesTable tv) async {
    try {
      await databaseHelper.insertWatchlistTVSeries(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeTVSeriesFromWatchList(TVSeriesTable tv) async {
    try {
      await databaseHelper.removeWatchlistTVSeries(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TVSeriesTable?> getTVSeriesById(int id) async {
    final result = await databaseHelper.getTVSeriesById(id);
    if (result != null) {
      return TVSeriesTable.fromMap(result);
    } else {
      return null;
    }
  }
}
