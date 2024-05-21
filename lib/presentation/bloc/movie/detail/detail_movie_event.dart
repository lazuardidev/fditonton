part of 'detail_movie_bloc.dart';

@immutable
sealed class DetailMovieEvent {
  const DetailMovieEvent();
}

final class LoadDetailMovie extends DetailMovieEvent {
  final int id;
  const LoadDetailMovie(this.id);
}
