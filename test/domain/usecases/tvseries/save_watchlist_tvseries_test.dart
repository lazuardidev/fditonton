import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tvseries/save_watchlist_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/tvseries/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchListTVSeries usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = SaveWatchListTVSeries(mockTVSeriesRepository);
  });

  test('should save tv to the repository', () async {
    // arrange
    when(mockTVSeriesRepository.saveWatchlistTVSeries(testTvDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    verify(mockTVSeriesRepository.saveWatchlistTVSeries(testTvDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
