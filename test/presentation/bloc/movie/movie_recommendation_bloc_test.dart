import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/movie/movie_recommendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MovieRecommendationBloc movieRecommendationBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieRecommendationBloc =
        MovieRecommendationBloc(mockGetMovieRecommendations);
  });

  test('initial should be empty', () {
    expect(movieRecommendationBloc.state, MovieRecommendationInitial());
  });

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
  const movieId = 1;

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
      'emits [Loading, Success] when data is gotten successfully',
      build: () {
        when(mockGetMovieRecommendations.execute(movieId))
            .thenAnswer((_) async => right(tMovieList));
        return movieRecommendationBloc;
      },
      act: (bloc) => bloc.add(const LoadMovieRecommendation(movieId)),
      expect: () => [
            MovieRecommendationLoading(),
            MovieRecommendationSuccess(tMovieList)
          ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(movieId));
      });

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
      'Should emit [Loading, Error] when get recommendation movie is unsuccessful',
      build: () {
        when(mockGetMovieRecommendations.execute(movieId)).thenAnswer(
            (_) async => left(const ServerFailure('Server Failure')));
        return movieRecommendationBloc;
      },
      act: (bloc) => bloc.add(const LoadMovieRecommendation(movieId)),
      expect: () => [
            MovieRecommendationLoading(),
            const MovieRecommendationError('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(movieId));
      });
}
