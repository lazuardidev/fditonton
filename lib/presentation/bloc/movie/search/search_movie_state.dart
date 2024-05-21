part of 'search_movie_bloc.dart';

@immutable
sealed class SearchMovieState extends Equatable {
  const SearchMovieState();

  @override
  List<Object> get props => [];
}

final class SearchMovieEmpty extends SearchMovieState {}

final class SearchMovieLoading extends SearchMovieState {}

final class SearchMovieError extends SearchMovieState {
  final String error;
  const SearchMovieError(this.error);

  @override
  List<Object> get props => [error];
}

final class SearchMovieSuccess extends SearchMovieState {
  final List<Movie> results;
  const SearchMovieSuccess(this.results);

  @override
  List<Object> get props => [results];
}
