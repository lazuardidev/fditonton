import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/search_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTVSeries usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = SearchTVSeries(mockTVSeriesRepository);
  });

  final tTvList = <TVSeries>[];
  const tQuery = 'Spiderman';

  test('should get list of tv from the repository', () async {
    // arrange
    when(mockTVSeriesRepository.searchTVSeries(tQuery))
        .thenAnswer((_) async => Right(tTvList));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTvList));
  });
}
