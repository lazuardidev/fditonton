part of 'now_playing_tvseries_bloc.dart';

@immutable
sealed class NowPlayingTVSeriesState extends Equatable {
  const NowPlayingTVSeriesState();

  @override
  List<Object> get props => [];
}

final class NowPlayingTVSeriesEmpty extends NowPlayingTVSeriesState {}

final class NowPlayingTVSeriesLoading extends NowPlayingTVSeriesState {}

final class NowPlayingTVSeriesError extends NowPlayingTVSeriesState {
  final String message;
  const NowPlayingTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

final class NowPlayingTVSeriesSuccess extends NowPlayingTVSeriesState {
  final List<TVSeries> results;
  const NowPlayingTVSeriesSuccess(this.results);

  @override
  List<Object> get props => [results];
}
