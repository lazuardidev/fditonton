import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_top_rated_tvseries.dart';
import 'package:ditonton/presentation/bloc/tvseries/toprated/top_rated_tvseries_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';

import 'top_rated_tvseries_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTVSeries])
void main() {
  late TopRatedTVSeriesBloc topRatedTVSeriesBloc;
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;

  setUp(() {
    mockGetTopRatedTVSeries = MockGetTopRatedTVSeries();
    topRatedTVSeriesBloc = TopRatedTVSeriesBloc(mockGetTopRatedTVSeries);
  });

  test('initial should be empty', () {
    expect(topRatedTVSeriesBloc.state, TopRatedTVSeriesEmpty());
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

  blocTest<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
      'Should emit Loading, Error when get top rated tv series is unsuccessful',
      build: () {
        when(mockGetTopRatedTVSeries.execute()).thenAnswer(
            (_) async => left(const ServerFailure('Server Failure')));
        return topRatedTVSeriesBloc;
      },
      act: (bloc) => bloc.add(LoadTopRatedTVSeries()),
      expect: () => [
            TopRatedTVSeriesLoading(),
            const TopRatedTVSeriesError('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedTVSeries.execute());
      });

  blocTest<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
      'emits Loading, Success when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTVSeries.execute())
            .thenAnswer((_) async => right(tvSeriesList));
        return topRatedTVSeriesBloc;
      },
      act: (bloc) => bloc.add(LoadTopRatedTVSeries()),
      expect: () =>
          [TopRatedTVSeriesLoading(), TopRatedTVSeriesSuccess(tvSeriesList)],
      verify: (bloc) {
        verify(mockGetTopRatedTVSeries.execute());
      });
}
