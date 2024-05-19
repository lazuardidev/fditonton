import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tvseries_recommendation.dart';
import 'package:ditonton/presentation/bloc/tvseries/tvseries_recommendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';

import 'tvseries_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetTVSeriesRecommendation])
void main() {
  late TVSeriesRecommendationBloc tvRecommendationBloc;
  late MockGetTVSeriesRecommendation mockGetTVSeriesRecommendation;

  setUp(() {
    mockGetTVSeriesRecommendation = MockGetTVSeriesRecommendation();
    tvRecommendationBloc =
        TVSeriesRecommendationBloc(mockGetTVSeriesRecommendation);
  });

  test('initial should be empty', () {
    expect(tvRecommendationBloc.state, TVSeriesRecommendationEmpty());
  });

  const tTVSeries = TVSeries(
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalName: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    firstAirDate: '2002-05-01',
    name: 'Spider-Man',
    voteAverage: 7.2,
    voteCount: 13507,
    originCountry: ['en'],
    originalLanguage: 'en',
  );

  final tTVSeriesList = <TVSeries>[tTVSeries];
  const tvId = 1;

  blocTest<TVSeriesRecommendationBloc, TVSeriesRecommendationState>(
      'emits [Loading, Success] when data is gotten successfully',
      build: () {
        when(mockGetTVSeriesRecommendation.execute(tvId))
            .thenAnswer((_) async => right(tTVSeriesList));
        return tvRecommendationBloc;
      },
      act: (bloc) => bloc.add(const LoadTVSeriesRecommendations(tvId)),
      expect: () => [
            TVSeriesRecommendationLoading(),
            TVSeriesRecommendationsSuccess(tTVSeriesList)
          ],
      verify: (bloc) {
        verify(mockGetTVSeriesRecommendation.execute(tvId));
      });

  blocTest<TVSeriesRecommendationBloc, TVSeriesRecommendationState>(
      'Should emit [Loading, Error] when get recommendations tv is unsuccessful',
      build: () {
        when(mockGetTVSeriesRecommendation.execute(tvId)).thenAnswer(
            (_) async => left(const ServerFailure('Server Failure')));
        return tvRecommendationBloc;
      },
      act: (bloc) => bloc.add(const LoadTVSeriesRecommendations(tvId)),
      expect: () => [
            TVSeriesRecommendationLoading(),
            const TVSeriesRecommendationError('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetTVSeriesRecommendation.execute(tvId));
      });
}
