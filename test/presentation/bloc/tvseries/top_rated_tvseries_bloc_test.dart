import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_top_rated_tvseries.dart';
import 'package:ditonton/presentation/bloc/tvseries/top_rated_tvseries_bloc.dart';
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

  blocTest<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
      'emits [Loading, Success] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTVSeries.execute())
            .thenAnswer((_) async => right(tTVSeriesList));
        return topRatedTVSeriesBloc;
      },
      act: (bloc) => bloc.add(LoadTopRatedTVSeries()),
      expect: () =>
          [TopRatedTVSeriesLoading(), TopRatedTVSeriesSuccess(tTVSeriesList)],
      verify: (bloc) {
        verify(mockGetTopRatedTVSeries.execute());
      });

  blocTest<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
      'Should emit [Loading, Error] when get top rated tv is unsuccessful',
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
}
