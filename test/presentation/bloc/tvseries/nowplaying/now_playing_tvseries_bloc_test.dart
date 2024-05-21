import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_now_playing_tvseries.dart';
import 'package:ditonton/presentation/bloc/tvseries/nowplaying/now_playing_tvseries_bloc.dart';
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

  blocTest<NowPlayingTVSeriesBloc, NowPlayingTVSeriesState>(
      'Should emit Loading, Error when get now playing tv series unsuccessful',
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

  blocTest<NowPlayingTVSeriesBloc, NowPlayingTVSeriesState>(
      'emits Loading, Success when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingTVSeries.execute())
            .thenAnswer((_) async => right(tvSeriesList));
        return nowPlayingTVSeriesBloc;
      },
      act: (bloc) => bloc.add(LoadNowPlayingTVSeries()),
      expect: () => [
            NowPlayingTVSeriesLoading(),
            NowPlayingTVSeriesSuccess(tvSeriesList)
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingTVSeries.execute());
      });
}
