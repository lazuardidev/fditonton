import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tvseries_recommendation.dart';
import 'package:ditonton/presentation/bloc/tvseries/recomendation/tvseries_recommendation_bloc.dart';
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

  const tvSeries = TVSeries(
    backdropPath: '/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg',
    genreIds: [18, 80],
    id: 278,
    originalName: 'The Shawshank Redemption',
    overview:
        'Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.',
    popularity: 161.431,
    posterPath: '/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg',
    firstAirDate: '1994-09-23',
    name: 'The Shawshank Redemption',
    voteAverage: 8.705,
    voteCount: 26158,
    originCountry: ['en'],
    originalLanguage: 'en',
  );

  final tvSeriesList = <TVSeries>[tvSeries];
  const tvId = 1;

  blocTest<TVSeriesRecommendationBloc, TVSeriesRecommendationState>(
      'Should emit Loading, Error when get recommendations tv series is unsuccess',
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

  blocTest<TVSeriesRecommendationBloc, TVSeriesRecommendationState>(
      'emits Loading, Success when data success',
      build: () {
        when(mockGetTVSeriesRecommendation.execute(tvId))
            .thenAnswer((_) async => right(tvSeriesList));
        return tvRecommendationBloc;
      },
      act: (bloc) => bloc.add(const LoadTVSeriesRecommendations(tvId)),
      expect: () => [
            TVSeriesRecommendationLoading(),
            TVSeriesRecommendationsSuccess(tvSeriesList)
          ],
      verify: (bloc) {
        verify(mockGetTVSeriesRecommendation.execute(tvId));
      });
}
