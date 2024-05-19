import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_now_playing_tvseries.dart';
import 'package:ditonton/presentation/bloc/tvseries/now_playing_tvseries_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import 'now_playing_tvseries_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTVSeries])
void main() {
  late NowPlayingTVSeriesBloc nowPlayingTVSeriesBloc;
  late MockGetNowPlayingTVSeries mockGetNowPlayingTVSeries;

  setUp(() {
    mockGetNowPlayingTVSeries = MockGetNowPlayingTVSeries();
    nowPlayingTVSeriesBloc = NowPlayingTVSeriesBloc(mockGetNowPlayingTVSeries);
  });

  test('initial should be empty', () {
    expect(nowPlayingTVSeriesBloc.state, NowPlayingTVSeriesEmpty());
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

  blocTest<NowPlayingTVSeriesBloc, NowPlayingTVSeriesState>(
      'emits [Loading, Success] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingTVSeries.execute())
            .thenAnswer((_) async => right(tTVSeriesList));
        return nowPlayingTVSeriesBloc;
      },
      act: (bloc) => bloc.add(LoadNowPlayingTVSeries()),
      expect: () => [
            NowPlayingTVSeriesLoading(),
            NowPlayingTVSeriesSuccess(tTVSeriesList)
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingTVSeries.execute());
      });

  blocTest<NowPlayingTVSeriesBloc, NowPlayingTVSeriesState>(
      'Should emit [Loading, Error] when get now playing tv is unsuccessful',
      build: () {
        when(mockGetNowPlayingTVSeries.execute()).thenAnswer(
            (_) async => left(const ServerFailure('Server Failure')));
        return nowPlayingTVSeriesBloc;
      },
      act: (bloc) => bloc.add(LoadNowPlayingTVSeries()),
      expect: () => [
            NowPlayingTVSeriesLoading(),
            const NowPlayingTVSeriesError('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingTVSeries.execute());
      });
}