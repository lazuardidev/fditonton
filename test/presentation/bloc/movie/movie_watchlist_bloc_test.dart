import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  SaveWatchlist,
  RemoveWatchlist,
  GetWatchListStatus,
  GetWatchlistMovies,
])
void main() {
  late MovieWatchlistBloc movieWatchlistBloc;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockSaveWatchlist = MockSaveWatchlist();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    movieWatchlistBloc = MovieWatchlistBloc(
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
      getWatchListStatus: mockGetWatchListStatus,
      getWatchlistMovies: mockGetWatchlistMovies,
    );
  });

  const movieId = 1;

  const movieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  const tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  group('Watchlist', () {
    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'emits [StatusAdded] when watchlist status gotten successfully',
      build: () {
        when(mockGetWatchListStatus.execute(movieId))
            .thenAnswer((_) async => true);
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(const LoadWatchListStatus(movieId)),
      expect: () => [const WatchListStatusAdded(true)],
      verify: (bloc) => mockGetWatchListStatus.execute(movieId),
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'emits [SuccessMessage] when save watchlist function called',
      build: () {
        when(mockSaveWatchlist.execute(movieDetail))
            .thenAnswer((_) async => right('Added to Watchlist'));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(const AddWatchList(movieDetail)),
      expect: () => [const SuccessMessage('Added to Watchlist')],
      verify: (bloc) => mockSaveWatchlist.execute(movieDetail),
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'emits [SuccessMessage] when remove watchlist function called',
      build: () {
        when(mockRemoveWatchlist.execute(movieDetail))
            .thenAnswer((_) async => right('Removed from Watchlist'));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(const RemoveFromWatchList(movieDetail)),
      expect: () => [const SuccessMessage('Removed from Watchlist')],
      verify: (bloc) => mockRemoveWatchlist.execute(movieDetail),
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should update watchlist status failed to remove',
      build: () {
        when(mockGetWatchListStatus.execute(movieId))
            .thenAnswer((_) async => false);
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(const LoadWatchListStatus(movieId)),
      expect: () => [const WatchListStatusAdded(false)],
      verify: (bloc) => mockGetWatchListStatus.execute(movieId),
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'emits [FailedMessage] when save watchlist failed',
      build: () {
        when(mockSaveWatchlist.execute(movieDetail)).thenAnswer(
            (_) async => left(const DatabaseFailure('Database failure')));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(const AddWatchList(movieDetail)),
      expect: () => [const FailedMessage('Database failure')],
      verify: (bloc) => mockSaveWatchlist.execute(movieDetail),
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'emits [FailedMessage] when remove watchlist failed',
      build: () {
        when(mockRemoveWatchlist.execute(movieDetail)).thenAnswer(
            (_) async => left(const DatabaseFailure('Database failure')));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(const RemoveFromWatchList(movieDetail)),
      expect: () => [const FailedMessage('Database failure')],
      verify: (bloc) => mockRemoveWatchlist.execute(movieDetail),
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'emits [Loading, Success] when data gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => right(tMovieList));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(const LoadWatchListMovie()),
      expect: () =>
          [MovieWatchListLoading(), MovieWatchListSuccess(tMovieList)],
      verify: (bloc) => mockGetWatchlistMovies.execute(),
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'emits [Loading, Error] when data unsuccessfully load',
      build: () {
        when(mockGetWatchlistMovies.execute()).thenAnswer(
            (_) async => left(const DatabaseFailure('Database failure')));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(const LoadWatchListMovie()),
      expect: () => [
        MovieWatchListLoading(),
        const MovieWatchListError('Database failure')
      ],
      verify: (bloc) => mockGetWatchlistMovies.execute(),
    );
  });
}
