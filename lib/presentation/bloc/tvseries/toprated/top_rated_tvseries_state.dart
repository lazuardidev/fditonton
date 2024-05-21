part of 'top_rated_tvseries_bloc.dart';

@immutable
sealed class TopRatedTVSeriesState extends Equatable {
  const TopRatedTVSeriesState();

  @override
  List<Object> get props => [];
}

final class TopRatedTVSeriesEmpty extends TopRatedTVSeriesState {}

final class TopRatedTVSeriesLoading extends TopRatedTVSeriesState {}

final class TopRatedTVSeriesError extends TopRatedTVSeriesState {
  final String message;
  const TopRatedTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

final class TopRatedTVSeriesSuccess extends TopRatedTVSeriesState {
  final List<TVSeries> results;
  const TopRatedTVSeriesSuccess(this.results);

  @override
  List<Object> get props => [results];
}
