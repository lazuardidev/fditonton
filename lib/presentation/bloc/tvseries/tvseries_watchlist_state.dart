part of 'tvseries_watchlist_bloc.dart';

@immutable
sealed class TVSeriesWatchlistState extends Equatable {
  const TVSeriesWatchlistState();

  @override
  List<Object> get props => [];
}

final class TVSeriesWatchlistInitial extends TVSeriesWatchlistState {}

final class SuccessMessage extends TVSeriesWatchlistState {
  final String message;
  const SuccessMessage(this.message);

  @override
  List<Object> get props => [message];
}

final class FailedMessage extends TVSeriesWatchlistState {
  final String message;
  const FailedMessage(this.message);

  @override
  List<Object> get props => [message];
}

final class WatchListStatusAdded extends TVSeriesWatchlistState {
  final bool isAddedToWatchList;
  const WatchListStatusAdded(this.isAddedToWatchList);

  @override
  List<Object> get props => [isAddedToWatchList];
}

final class TVSeriesWatchListLoading extends TVSeriesWatchlistState {}

final class TVSeriesWatchListSuccess extends TVSeriesWatchlistState {
  final List<TVSeries> results;
  const TVSeriesWatchListSuccess(this.results);

  @override
  List<Object> get props => [results];
}

final class TVSeriesWatchListError extends TVSeriesWatchlistState {
  final String message;
  const TVSeriesWatchListError(this.message);

  @override
  List<Object> get props => [message];
}
