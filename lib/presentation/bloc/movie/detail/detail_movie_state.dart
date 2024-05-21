part of 'detail_movie_bloc.dart';

@immutable
sealed class DetailMovieState extends Equatable {
  const DetailMovieState();

  @override
  List<Object> get props => [];
}

final class DetailMovieInitial extends DetailMovieState {}

final class DetailMovieLoading extends DetailMovieState {}

final class DetailMovieSuccess extends DetailMovieState {
  final MovieDetail result;
  const DetailMovieSuccess(this.result);

  @override
  List<Object> get props => [result];
}

final class DetailMovieError extends DetailMovieState {
  final String message;
  const DetailMovieError(this.message);

  @override
  List<Object> get props => [message];
}
