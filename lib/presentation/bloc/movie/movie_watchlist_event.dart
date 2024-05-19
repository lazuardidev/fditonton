part of 'movie_watchlist_bloc.dart';

@immutable
sealed class MovieWatchlistEvent {
  const MovieWatchlistEvent();
}

final class AddWatchList extends MovieWatchlistEvent {
  final MovieDetail movie;
  const AddWatchList(this.movie);
}

final class RemoveFromWatchList extends MovieWatchlistEvent {
  final MovieDetail movie;
  const RemoveFromWatchList(this.movie);
}

final class LoadWatchListStatus extends MovieWatchlistEvent {
  final int id;
  const LoadWatchListStatus(this.id);
}

final class LoadWatchListMovie extends MovieWatchlistEvent {
  const LoadWatchListMovie();
}
