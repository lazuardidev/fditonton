part of 'tvseries_detail_bloc.dart';

@immutable
sealed class TVSeriesDetailState extends Equatable {
  const TVSeriesDetailState();

  @override
  List<Object> get props => [];
}

final class TVSeriesDetailEmpty extends TVSeriesDetailState {}

final class TVSeriesDetailLoading extends TVSeriesDetailState {}

final class TVSeriesDetailError extends TVSeriesDetailState {
  final String message;
  const TVSeriesDetailError(this.message);

  @override
  List<Object> get props => [message];
}

final class TVSeriesDetailSuccess extends TVSeriesDetailState {
  final TVSeriesDetail result;

  const TVSeriesDetailSuccess({required this.result});

  @override
  List<Object> get props => [result];
}
