import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_tvseries.dart';
import 'package:ditonton/presentation/provider/tvseries/watch_list_tvseries_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/tvseries/dummy_objects.dart';
import 'watch_list_tvseries_notifier_test.mocks.dart';

@GenerateMocks([GetWatchListTVSeries])
void main() {
  late WatchListTVSeriesNotifier watchListTVSeriesNotifier;
  late MockGetWatchListTVSeries mockGetWatchListTVSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchListTVSeries = MockGetWatchListTVSeries();
    watchListTVSeriesNotifier = WatchListTVSeriesNotifier(
      getWatchListTv: mockGetWatchListTVSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('should change tv data when data is gotten successfully', () async {
    // arrange
    when(mockGetWatchListTVSeries.execute())
        .thenAnswer((_) async => const Right([testWatchlistTv]));
    // act
    await watchListTVSeriesNotifier.fetchWatchlistTv();
    // assert
    expect(watchListTVSeriesNotifier.watchlistState, RequestState.Loaded);
    expect(watchListTVSeriesNotifier.watchlistTv, [testWatchlistTv]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchListTVSeries.execute())
        .thenAnswer((_) async => const Left(DatabaseFailure("Can't get data")));
    // act
    await watchListTVSeriesNotifier.fetchWatchlistTv();
    // assert
    expect(watchListTVSeriesNotifier.watchlistState, RequestState.Error);
    expect(watchListTVSeriesNotifier.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}
