part of 'tvseries_watchlist_bloc.dart';

@immutable
sealed class TVSeriesWatchlistEvent {
  const TVSeriesWatchlistEvent();
}

final class AddWatchList extends TVSeriesWatchlistEvent {
  final TVSeriesDetail tv;
  const AddWatchList(this.tv);
}

final class RemoveFromWatchList extends TVSeriesWatchlistEvent {
  final TVSeriesDetail tv;
  const RemoveFromWatchList(this.tv);
}

final class LoadWatchListStatus extends TVSeriesWatchlistEvent {
  final int id;
  const LoadWatchListStatus(this.id);
}

final class LoadWatchListTVSeries extends TVSeriesWatchlistEvent {
  const LoadWatchListTVSeries();
}
