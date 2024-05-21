part of 'watchlist_movie_bloc.dart';

@immutable
sealed class WatchlistMovieEvent {
  const WatchlistMovieEvent();
}

final class LoadWatchListStatus extends WatchlistMovieEvent {
  final int id;
  const LoadWatchListStatus(this.id);
}

final class LoadWatchListMovie extends WatchlistMovieEvent {
  const LoadWatchListMovie();
}

final class AddWatchList extends WatchlistMovieEvent {
  final MovieDetail movie;
  const AddWatchList(this.movie);
}

final class RemoveFromWatchList extends WatchlistMovieEvent {
  final MovieDetail movie;
  const RemoveFromWatchList(this.movie);
}
