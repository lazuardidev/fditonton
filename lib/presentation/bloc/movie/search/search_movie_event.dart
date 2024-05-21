part of 'search_movie_bloc.dart';

@immutable
sealed class SearchMovieEvent {
  const SearchMovieEvent();
}

final class OnQueryChanged extends SearchMovieEvent {
  final String query;
  const OnQueryChanged(this.query);
}
