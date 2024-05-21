part of 'recommendation_movie_bloc.dart';

@immutable
sealed class RecommendationMovieEvent {
  const RecommendationMovieEvent();
}

final class LoadRecommendationMovie extends RecommendationMovieEvent {
  final int id;
  const LoadRecommendationMovie(this.id);
}
