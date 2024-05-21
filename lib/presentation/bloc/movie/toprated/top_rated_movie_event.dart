part of 'top_rated_movie_bloc.dart';

@immutable
sealed class TopRatedMovieEvent {
  const TopRatedMovieEvent();
}

final class LoadTopRatedMovie extends TopRatedMovieEvent {}
