import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_popular_tvseries.dart';
import 'package:ditonton/presentation/bloc/tvseries/popular_tvseries_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import 'popular_tvseries_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTVSeries])
void main() {
  late PopularTVSeriesBloc popularTVSeriesBloc;
  late MockGetPopularTVSeries mockGetPopularTVSeries;

  setUp(() {
    mockGetPopularTVSeries = MockGetPopularTVSeries();
    popularTVSeriesBloc = PopularTVSeriesBloc(mockGetPopularTVSeries);
  });

  test('initial should be empty', () {
    expect(popularTVSeriesBloc.state, PopularTVSeriesEmpty());
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

  blocTest<PopularTVSeriesBloc, PopularTVSeriesState>(
      'emits [Loading, Success] when data is gotten successfully',
      build: () {
        when(mockGetPopularTVSeries.execute())
            .thenAnswer((_) async => right(tTVSeriesList));
        return popularTVSeriesBloc;
      },
      act: (bloc) => bloc.add(LoadPopularTVSeries()),
      expect: () =>
          [PopularTVSeriesLoading(), PopularTVSeriesSuccess(tTVSeriesList)],
      verify: (bloc) {
        verify(mockGetPopularTVSeries.execute());
      });

  blocTest<PopularTVSeriesBloc, PopularTVSeriesState>(
      'Should emit [Loading, Error] when get popular tv is unsuccessful',
      build: () {
        when(mockGetPopularTVSeries.execute()).thenAnswer(
            (_) async => left(const ServerFailure('Server Failure')));
        return popularTVSeriesBloc;
      },
      act: (bloc) => bloc.add(LoadPopularTVSeries()),
      expect: () => [
            PopularTVSeriesLoading(),
            const PopularTVSeriesError('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetPopularTVSeries.execute());
      });
}
