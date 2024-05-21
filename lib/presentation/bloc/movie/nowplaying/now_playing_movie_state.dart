part of 'now_playing_movie_bloc.dart';

@immutable
sealed class NowPlayingMovieState extends Equatable {
  const NowPlayingMovieState();

  @override
  List<Object> get props => [];
}

final class NowPlayingMovieInitial extends NowPlayingMovieState {}

final class NowPlayingMovieLoading extends NowPlayingMovieState {}

final class NowPlayingMovieSuccess extends NowPlayingMovieState {
  final List<Movie> results;
  const NowPlayingMovieSuccess(this.results);

  @override
  List<Object> get props => [results];
}

final class NowPlayingMovieError extends NowPlayingMovieState {
  final String message;
  const NowPlayingMovieError(this.message);

  @override
  List<Object> get props => [message];
}
