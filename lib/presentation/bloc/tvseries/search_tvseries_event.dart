part of 'search_tvseries_bloc.dart';

@immutable
sealed class SearchTVSeriesEvent {
  const SearchTVSeriesEvent();
}

final class OnQueryChangedTVSeries extends SearchTVSeriesEvent {
  final String query;
  const OnQueryChangedTVSeries(this.query);
}
