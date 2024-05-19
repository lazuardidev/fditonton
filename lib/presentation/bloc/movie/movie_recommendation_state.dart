part of 'movie_recommendation_bloc.dart';

@immutable
sealed class MovieRecommendationState extends Equatable {
  const MovieRecommendationState();

  @override
  List<Object> get props => [];
}

final class MovieRecommendationInitial extends MovieRecommendationState {}

final class MovieRecommendationLoading extends MovieRecommendationState {}

final class MovieRecommendationSuccess extends MovieRecommendationState {
  final List<Movie> results;
  const MovieRecommendationSuccess(this.results);

  @override
  List<Object> get props => [results];
}

final class MovieRecommendationError extends MovieRecommendationState {
  final String error;
  const MovieRecommendationError(this.error);

  @override
  List<Object> get props => [error];
}
