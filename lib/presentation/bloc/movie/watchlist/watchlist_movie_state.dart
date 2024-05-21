part of 'watchlist_movie_bloc.dart';

@immutable
sealed class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object> get props => [];
}

final class WatchlistMovieInitial extends WatchlistMovieState {}

final class WatchListMovieSuccess extends WatchlistMovieState {
  final List<Movie> results;
  const WatchListMovieSuccess(this.results);

  @override
  List<Object> get props => [results];
}

final class WatchListMovieError extends WatchlistMovieState {
  final String message;
  const WatchListMovieError(this.message);

  @override
  List<Object> get props => [message];
}

final class SuccessMessage extends WatchlistMovieState {
  final String message;
  const SuccessMessage(this.message);

  @override
  List<Object> get props => [message];
}

final class FailedMessage extends WatchlistMovieState {
  final String message;
  const FailedMessage(this.message);

  @override
  List<Object> get props => [message];
}

final class WatchListStatusAdded extends WatchlistMovieState {
  final bool isAddedToWatchList;
  const WatchListStatusAdded(this.isAddedToWatchList);

  @override
  List<Object> get props => [isAddedToWatchList];
}

final class WatchListMovieLoading extends WatchlistMovieState {}
