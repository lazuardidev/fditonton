part of 'movie_detail_bloc.dart';

@immutable
sealed class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

final class MovieDetailInitial extends MovieDetailState {}

final class MovieDetailLoading extends MovieDetailState {}

final class MovieDetailSuccess extends MovieDetailState {
  final MovieDetail result;
  const MovieDetailSuccess(this.result);

  @override
  List<Object> get props => [result];
}

final class MovieDetailError extends MovieDetailState {
  final String message;
  const MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}
