import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie/detail/detail_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'detail_movie_bloc_test.mocks.dart';

@GenerateMocks([GetDetailMovie])
void main() {
  late DetailMovieBloc detailMovieBloc;
  late MockGetDetailMovie mockGetDetailMovie;

  setUp(() {
    mockGetDetailMovie = MockGetDetailMovie();
    detailMovieBloc = DetailMovieBloc(mockGetDetailMovie);
  });

  test('initial should be empty', () {
    expect(detailMovieBloc.state, DetailMovieInitial());
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

  blocTest<DetailMovieBloc, DetailMovieState>(
      'emits Loading, Success when data successfully',
      build: () {
        when(mockGetDetailMovie.execute(movieId))
            .thenAnswer((_) async => right(movieDetail));
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(const LoadDetailMovie(movieId)),
      expect: () =>
          [DetailMovieLoading(), const DetailMovieSuccess(movieDetail)],
      verify: (bloc) {
        verify(mockGetDetailMovie.execute(movieId));
      });

  blocTest<DetailMovieBloc, DetailMovieState>(
      'emits Loading, Error when data unsuccessfully',
      build: () {
        when(mockGetDetailMovie.execute(movieId)).thenAnswer(
            (_) async => left(const ServerFailure('Server failure')));
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(const LoadDetailMovie(movieId)),
      expect: () =>
          [DetailMovieLoading(), const DetailMovieError('Server failure')],
      verify: (bloc) {
        verify(mockGetDetailMovie.execute(movieId));
      });
}
