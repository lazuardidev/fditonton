part of 'popular_movie_bloc.dart';

@immutable
sealed class PopularMovieEvent {
  const PopularMovieEvent();
}

final class LoadPopularMovie extends PopularMovieEvent {}
