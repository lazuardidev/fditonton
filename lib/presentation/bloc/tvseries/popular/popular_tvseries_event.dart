part of 'popular_tvseries_bloc.dart';

@immutable
sealed class PopularTVSeriesEvent {
  const PopularTVSeriesEvent();
}

final class LoadPopularTVSeries extends PopularTVSeriesEvent {}
