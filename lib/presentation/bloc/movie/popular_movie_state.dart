part of 'popular_movie_bloc.dart';

@immutable
sealed class PopularMovieState extends Equatable {
  const PopularMovieState();

  @override
  List<Object> get props => [];
}

final class PopularMovieInitial extends PopularMovieState {}

final class PopularMovieLoading extends PopularMovieState {}

final class PopularMovieSuccess extends PopularMovieState {
  final List<Movie> result;
  const PopularMovieSuccess(this.result);

  @override
  List<Object> get props => [result];
}

final class PopularMovieError extends PopularMovieState {
  final String message;
  const PopularMovieError(this.message);

  @override
  List<Object> get props => [message];
}
