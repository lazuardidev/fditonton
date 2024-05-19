import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries_detail.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_tvseries_status.dart';
import 'package:ditonton/domain/usecases/tvseries/remove_watchlist_tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/save_watchlist_tvseries.dart';
import 'package:ditonton/presentation/bloc/tvseries/tvseries_watchlist_bloc.dart';
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

  group('Watchlist', () {
    blocTest<TVSeriesWatchlistBloc, TVSeriesWatchlistState>(
      'emits [StatusAdded] when watchlist status gotten successfully',
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
      'emits [SuccessMessage] when save watchlist function called',
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
      'emits [SuccessMessage] when remove watchlist function called',
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
      'emits [FailedMessage] when save watchlist failed',
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
      'emits [FailedMessage] when remove watchlist failed',
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
      'emits [Loading, Success] when data gotten successfully',
      build: () {
        when(mockGetWatchListTVSeries.execute())
            .thenAnswer((_) async => right(tTVSeriesList));
        return tvSeriesWatchlistBloc;
      },
      act: (bloc) => bloc.add(const LoadWatchListTVSeries()),
      expect: () =>
          [TVSeriesWatchListLoading(), TVSeriesWatchListSuccess(tTVSeriesList)],
      verify: (bloc) => mockGetWatchListTVSeries.execute(),
    );

    blocTest<TVSeriesWatchlistBloc, TVSeriesWatchlistState>(
      'emits [Loading, Error] when data unsuccessfully load',
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
