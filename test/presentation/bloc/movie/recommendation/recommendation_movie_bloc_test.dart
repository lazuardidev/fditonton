import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/movie/recomendation/recommendation_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'recommendation_movie_bloc_test.mocks.dart';

@GenerateMocks([GetRecommendationMovie])
void main() {
  late RecommendationMovieBloc recommendationMovieBloc;
  late MockGetRecommendationMovie mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetRecommendationMovie();
    recommendationMovieBloc =
        RecommendationMovieBloc(mockGetMovieRecommendations);
  });

  test('initial should be empty', () {
    expect(recommendationMovieBloc.state, RecommendationMovieInitial());
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

  blocTest<RecommendationMovieBloc, RecommendationMovieState>(
      'emits Loading, Success when data successfully',
      build: () {
        when(mockGetMovieRecommendations.execute(movieId))
            .thenAnswer((_) async => right(tMovieList));
        return recommendationMovieBloc;
      },
      act: (bloc) => bloc.add(const LoadRecommendationMovie(movieId)),
      expect: () => [
            RecommendationMovieLoading(),
            RecommendationMovieSuccess(tMovieList)
          ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(movieId));
      });

  blocTest<RecommendationMovieBloc, RecommendationMovieState>(
      'Should emit Loading, Error when get recommendation movie unsuccessful',
      build: () {
        when(mockGetMovieRecommendations.execute(movieId)).thenAnswer(
            (_) async => left(const ServerFailure('Server Failure')));
        return recommendationMovieBloc;
      },
      act: (bloc) => bloc.add(const LoadRecommendationMovie(movieId)),
      expect: () => [
            RecommendationMovieLoading(),
            const RecommendationMovieError('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(movieId));
      });
}
