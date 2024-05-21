part of 'recommendation_movie_bloc.dart';

@immutable
sealed class RecommendationMovieState extends Equatable {
  const RecommendationMovieState();

  @override
  List<Object> get props => [];
}

final class RecommendationMovieInitial extends RecommendationMovieState {}

final class RecommendationMovieLoading extends RecommendationMovieState {}

final class RecommendationMovieSuccess extends RecommendationMovieState {
  final List<Movie> results;
  const RecommendationMovieSuccess(this.results);

  @override
  List<Object> get props => [results];
}

final class RecommendationMovieError extends RecommendationMovieState {
  final String error;
  const RecommendationMovieError(this.error);

  @override
  List<Object> get props => [error];
}
