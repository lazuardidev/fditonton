part of 'popular_tvseries_bloc.dart';

@immutable
sealed class PopularTVSeriesState extends Equatable {
  const PopularTVSeriesState();

  @override
  List<Object> get props => [];
}

final class PopularTVSeriesEmpty extends PopularTVSeriesState {}

final class PopularTVSeriesLoading extends PopularTVSeriesState {}

final class PopularTVSeriesError extends PopularTVSeriesState {
  final String message;
  const PopularTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

final class PopularTVSeriesSuccess extends PopularTVSeriesState {
  final List<TVSeries> results;
  const PopularTVSeriesSuccess(this.results);

  @override
  List<Object> get props => [results];
}
