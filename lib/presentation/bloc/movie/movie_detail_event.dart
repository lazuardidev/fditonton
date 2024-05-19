part of 'movie_detail_bloc.dart';

@immutable
sealed class MovieDetailEvent {
  const MovieDetailEvent();
}

final class LoadMovieDetail extends MovieDetailEvent {
  final int id;
  const LoadMovieDetail(this.id);
}
