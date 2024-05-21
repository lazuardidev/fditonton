part of 'now_playing_tvseries_bloc.dart';

@immutable
sealed class NowPlayingTVSeriesEvent {
  const NowPlayingTVSeriesEvent();
}

final class LoadNowPlayingTVSeries extends NowPlayingTVSeriesEvent {}
