part of 'movie_watchlist_bloc.dart';

@immutable
sealed class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object> get props => [];
}

final class MovieWatchlistInitial extends MovieWatchlistState {}

final class SuccessMessage extends MovieWatchlistState {
  final String message;
  const SuccessMessage(this.message);

  @override
  List<Object> get props => [message];
}

final class FailedMessage extends MovieWatchlistState {
  final String message;
  const FailedMessage(this.message);

  @override
  List<Object> get props => [message];
}

final class WatchListStatusAdded extends MovieWatchlistState {
  final bool isAddedToWatchList;
  const WatchListStatusAdded(this.isAddedToWatchList);

  @override
  List<Object> get props => [isAddedToWatchList];
}

final class MovieWatchListLoading extends MovieWatchlistState {}

final class MovieWatchListSuccess extends MovieWatchlistState {
  final List<Movie> results;
  const MovieWatchListSuccess(this.results);

  @override
  List<Object> get props => [results];
}

final class MovieWatchListError extends MovieWatchlistState {
  final String message;
  const MovieWatchListError(this.message);

  @override
  List<Object> get props => [message];
}
