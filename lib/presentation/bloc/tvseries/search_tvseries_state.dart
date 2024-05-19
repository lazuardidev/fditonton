part of 'search_tvseries_bloc.dart';

@immutable
sealed class SearchTVSeriesState extends Equatable {
  const SearchTVSeriesState();

  @override
  List<Object> get props => [];
}

final class SearchTVSeriesEmpty extends SearchTVSeriesState {}

final class SearchTVSeriesLoading extends SearchTVSeriesState {}

final class SearchTVSeriesError extends SearchTVSeriesState {
  final String error;
  const SearchTVSeriesError(this.error);

  @override
  List<Object> get props => [error];
}

final class SearchTVSeriesSuccess extends SearchTVSeriesState {
  final List<TVSeries> results;
  const SearchTVSeriesSuccess(this.results);

  @override
  List<Object> get props => [results];
}
