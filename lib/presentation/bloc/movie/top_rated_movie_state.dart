part of 'top_rated_movie_bloc.dart';

@immutable
sealed class TopRatedMovieState extends Equatable {
  const TopRatedMovieState();

  @override
  List<Object> get props => [];
}

final class TopRatedMovieInitial extends TopRatedMovieState {}

final class TopRatedMovieLoading extends TopRatedMovieState {}

final class TopRatedMovieSuccess extends TopRatedMovieState {
  final List<Movie> result;
  const TopRatedMovieSuccess(this.result);

  @override
  List<Object> get props => [result];
}

final class TopRatedMovieError extends TopRatedMovieState {
  final String message;
  const TopRatedMovieError(this.message);

  @override
  List<Object> get props => [message];
}
