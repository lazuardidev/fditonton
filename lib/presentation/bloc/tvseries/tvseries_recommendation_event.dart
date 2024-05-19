part of 'tvseries_recommendation_bloc.dart';

@immutable
sealed class TVSeriesRecommendationEvent {
  const TVSeriesRecommendationEvent();
}

final class LoadTVSeriesRecommendations extends TVSeriesRecommendationEvent {
  final int id;
  const LoadTVSeriesRecommendations(this.id);
}
