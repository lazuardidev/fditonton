part of 'movie_recommendation_bloc.dart';

@immutable
sealed class MovieRecommendationEvent {
  const MovieRecommendationEvent();
}

final class LoadMovieRecommendation extends MovieRecommendationEvent {
  final int id;
  const LoadMovieRecommendation(this.id);
}
