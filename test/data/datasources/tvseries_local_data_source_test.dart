import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tvseries/tvseries_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/tvseries/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVSeriesLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TVSeriesLocalDataSourceImpl(
      databaseHelper: mockDatabaseHelper,
    );
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistTVSeries(testTvTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertTVSeriesToWatchList(testTvTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistTVSeries(testTvTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertTVSeriesToWatchList(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistTVSeries(testTvTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeTVSeriesFromWatchList(testTvTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistTVSeries(testTvTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeTVSeriesFromWatchList(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get TV Detail By Id', () {
    const tId = 1;

    test('should return TV Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getTVSeriesById(tId))
          .thenAnswer((_) async => testTvMap);
      // act
      final result = await dataSource.getTVSeriesById(tId);
      // assert
      expect(result, testTvTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTVSeriesById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTVSeriesById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist tv', () {
    test('should return list of TVSeriesTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTVSeries())
          .thenAnswer((_) async => [testTvMap]);
      // act
      final result = await dataSource.getWatchListTVSeries();
      // assert
      expect(result, [testTvTable]);
    });
  });
}
