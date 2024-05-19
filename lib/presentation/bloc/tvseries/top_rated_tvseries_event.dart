part of 'top_rated_tvseries_bloc.dart';

@immutable
sealed class TopRatedTVSeriesEvent {
  const TopRatedTVSeriesEvent();
}

final class LoadTopRatedTVSeries extends TopRatedTVSeriesEvent {}
