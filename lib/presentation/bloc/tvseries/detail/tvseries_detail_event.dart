part of 'tvseries_detail_bloc.dart';

@immutable
sealed class TVSeriesDetailEvent {
  const TVSeriesDetailEvent();
}

final class LoadTVSeriesDetail extends TVSeriesDetailEvent {
  final int id;
  const LoadTVSeriesDetail(this.id);
}
