import 'package:ditonton/domain/usecases/tvseries/get_watchlist_tvseries_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListTVSeriesStatus usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetWatchListTVSeriesStatus(mockTVSeriesRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockTVSeriesRepository.isAddedToWatchlistTVSeries(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
