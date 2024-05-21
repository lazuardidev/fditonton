import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries_detail.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_tvseries_status.dart';
import 'package:ditonton/domain/usecases/tvseries/remove_watchlist_tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/save_watchlist_tvseries.dart';
import 'package:ditonton/presentation/bloc/tvseries/watchlist/tvseries_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import 'tvseries_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  RemoveWatchListTVSeries,
  SaveWatchListTVSeries,
  GetWatchListTVSeriesStatus,
  GetWatchListTVSeries,
])
void main() {
  late TVSeriesWatchlistBloc tvSeriesWatchlistBloc;
  late MockRemoveWatchListTVSeries mockRemoveWatchListTVSeries;
  late MockSaveWatchListTVSeries mockSaveWatchListTVSeries;
  late MockGetWatchListTVSeriesStatus mockGetWatchListTVSeriesStatus;
  late MockGetWatchListTVSeries mockGetWatchListTVSeries;

  setUp(() {
    mockRemoveWatchListTVSeries = MockRemoveWatchListTVSeries();
    mockSaveWatchListTVSeries = MockSaveWatchListTVSeries();
    mockGetWatchListTVSeriesStatus = MockGetWatchListTVSeriesStatus();
    mockGetWatchListTVSeries = MockGetWatchListTVSeries();
    tvSeriesWatchlistBloc = TVSeriesWatchlistBloc(
      saveWatchListTVSeries: mockSaveWatchListTVSeries,
      removeWatchListTVSeries: mockRemoveWatchListTVSeries,
      getWatchListTVSeriesStatus: mockGetWatchListTVSeriesStatus,
      getWatchListTVSeries: mockGetWatchListTVSeries,
    );
  });

  const tId = 1;

  const List<Season> seasons = [
    Season(
      airDate: 'airDate',
      episodeCount: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 1,
      voteAverage: 1,
    )
  ];

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

  const tvDetail = TVSeriesDetail(
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    lastAirDate: 'lastAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
    episodeRunTime: [1],
    homepage: 'homePage',
    inProduction: true,
    languages: ['en'],
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originCountry: ['USA'],
    originalLanguage: 'en',
    popularity: 1,
    seasons: seasons,
    status: 'status',
    tagline: 'tagLine',
    type: 'type',
  );

  final tvSeriesList = <TVSeries>[tvSeries];

  group('Watchlist', () {
    blocTest<TVSeriesWatchlistBloc, TVSeriesWatchlistState>(
      'emits StatusAdded when watchlist status gotten successfully',
      build: () {
        when(mockGetWatchListTVSeriesStatus.execute(tId))
            .thenAnswer((_) async => true);
        return tvSeriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(const LoadWatchListStatus(tId)),
      expect: () => [const WatchListStatusAdded(true)],
      verify: (bloc) => mockGetWatchListTVSeriesStatus.execute(tId),
    );

    blocTest<TVSeriesWatchlistBloc, TVSeriesWatchlistState>(
      'emits SuccessMessage when save watchlist function called',
      build: () {
        when(mockSaveWatchListTVSeries.execute(tvDetail))
            .thenAnswer((_) async => right('Added to Watchlist'));
        return tvSeriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(const AddWatchList(tvDetail)),
      expect: () => [const SuccessMessage('Added to Watchlist')],
      verify: (bloc) => mockSaveWatchListTVSeries.execute(tvDetail),
    );

    blocTest<TVSeriesWatchlistBloc, TVSeriesWatchlistState>(
      'emits SuccessMessage when remove watchlist function called',
      build: () {
        when(mockRemoveWatchListTVSeries.execute(tvDetail))
            .thenAnswer((_) async => right('Removed from Watchlist'));
        return tvSeriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(const RemoveFromWatchList(tvDetail)),
      expect: () => [const SuccessMessage('Removed from Watchlist')],
      verify: (bloc) => mockRemoveWatchListTVSeries.execute(tvDetail),
    );

    blocTest<TVSeriesWatchlistBloc, TVSeriesWatchlistState>(
      'should update watchlist status failed to remove',
      build: () {
        when(mockGetWatchListTVSeriesStatus.execute(tId))
            .thenAnswer((_) async => false);
        return tvSeriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(const LoadWatchListStatus(tId)),
      expect: () => [const WatchListStatusAdded(false)],
      verify: (bloc) => mockGetWatchListTVSeriesStatus.execute(tId),
    );

    blocTest<TVSeriesWatchlistBloc, TVSeriesWatchlistState>(
      'emits FailedMessage when save watchlist failed',
      build: () {
        when(mockSaveWatchListTVSeries.execute(tvDetail)).thenAnswer(
            (_) async => left(const DatabaseFailure('Database failure')));
        return tvSeriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(const AddWatchList(tvDetail)),
      expect: () => [const FailedMessage('Database failure')],
      verify: (bloc) => mockSaveWatchListTVSeries.execute(tvDetail),
    );

    blocTest<TVSeriesWatchlistBloc, TVSeriesWatchlistState>(
      'emits FailedMessage when remove watchlist failed',
      build: () {
        when(mockRemoveWatchListTVSeries.execute(tvDetail)).thenAnswer(
            (_) async => left(const DatabaseFailure('Database failure')));
        return tvSeriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(const RemoveFromWatchList(tvDetail)),
      expect: () => [const FailedMessage('Database failure')],
      verify: (bloc) => mockRemoveWatchListTVSeries.execute(tvDetail),
    );

    blocTest<TVSeriesWatchlistBloc, TVSeriesWatchlistState>(
      'emits Loading, Success when data gotten successfully',
      build: () {
        when(mockGetWatchListTVSeries.execute())
            .thenAnswer((_) async => right(tvSeriesList));
        return tvSeriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(const LoadWatchListTVSeries()),
      expect: () =>
          [TVSeriesWatchListLoading(), TVSeriesWatchListSuccess(tvSeriesList)],
      verify: (bloc) => mockGetWatchListTVSeries.execute(),
    );

    blocTest<TVSeriesWatchlistBloc, TVSeriesWatchlistState>(
      'emits Loading, Error when data unsuccessfully load',
      build: () {
        when(mockGetWatchListTVSeries.execute()).thenAnswer(
            (_) async => left(const DatabaseFailure('Database failure')));
        return tvSeriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(const LoadWatchListTVSeries()),
      expect: () => [
        TVSeriesWatchListLoading(),
        const TVSeriesWatchListError('Database failure')
      ],
      verify: (bloc) => mockGetWatchListTVSeries.execute(),
    );
  });
}
