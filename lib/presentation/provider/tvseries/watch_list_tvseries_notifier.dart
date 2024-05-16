import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_tvseries.dart';
import 'package:flutter/foundation.dart';

class WatchListTVSeriesNotifier extends ChangeNotifier {
  var _watchlistTv = <TVSeries>[];
  List<TVSeries> get watchlistTv => _watchlistTv;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchListTVSeriesNotifier({required this.getWatchListTv});

  final GetWatchListTVSeries getWatchListTv;

  Future<void> fetchWatchlistTv() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchListTv.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _watchlistState = RequestState.Loaded;
        _watchlistTv = tvData;
        notifyListeners();
      },
    );
  }
}
