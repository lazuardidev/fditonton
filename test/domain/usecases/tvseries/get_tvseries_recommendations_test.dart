import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tvseries_recommendation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVSeriesRecommendation usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetTVSeriesRecommendation(mockTVSeriesRepository);
  });

  const tId = 1;
  final tTvList = <TVSeries>[];

  test('should get list of tv recommendations from the repository', () async {
    // arrange
    when(mockTVSeriesRepository.getTVSeriesRecommendations(tId))
        .thenAnswer((_) async => Right(tTvList));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tTvList));
  });
}
