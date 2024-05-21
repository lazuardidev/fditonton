part of 'tvseries_recommendation_bloc.dart';

@immutable
sealed class TVSeriesRecommendationState extends Equatable {
  const TVSeriesRecommendationState();

  @override
  List<Object> get props => [];
}

final class TVSeriesRecommendationEmpty extends TVSeriesRecommendationState {}

final class TVSeriesRecommendationLoading extends TVSeriesRecommendationState {}

final class TVSeriesRecommendationsSuccess extends TVSeriesRecommendationState {
  final List<TVSeries> recommendations;
  const TVSeriesRecommendationsSuccess(this.recommendations);

  @override
  List<Object> get props => [recommendations];
}

final class TVSeriesRecommendationError extends TVSeriesRecommendationState {
  final String message;
  const TVSeriesRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}
