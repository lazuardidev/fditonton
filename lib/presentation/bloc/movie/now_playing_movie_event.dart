part of 'now_playing_movie_bloc.dart';

@immutable
sealed class NowPlayingMovieEvent {
  const NowPlayingMovieEvent();
}

final class LoadNowPlayingMovie extends NowPlayingMovieEvent {}
