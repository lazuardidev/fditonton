import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries_detail.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tvseries_detail.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tvseries_recommendation.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_tvseries_status.dart';
import 'package:ditonton/domain/usecases/tvseries/remove_watchlist_tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/save_watchlist_tvseries.dart';
import 'package:flutter/cupertino.dart';

class TVSeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTVSeriesDetail getTVSeriesDetail;
  final GetTVSeriesRecommendation getTVSeriesRecommendations;
  final GetWatchListTVSeriesStatus getWatchListTvStatus;
  final SaveWatchListTVSeries saveWatchListTv;
  final RemoveWatchListTVSeries removeWatchListTv;

  TVSeriesDetailNotifier({
    required this.getTVSeriesDetail,
    required this.getTVSeriesRecommendations,
    required this.getWatchListTvStatus,
    required this.saveWatchListTv,
    required this.removeWatchListTv,
  });

  late TVSeriesDetail _tv;
  TVSeriesDetail get tv => _tv;

  RequestState _tvState = RequestState.Empty;
  RequestState get tvState => _tvState;

  List<TVSeries> _tvRecommendations = [];
  List<TVSeries> get tvRecommendations => _tvRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchTvDetail(int id) async {
    _tvState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTVSeriesDetail.execute(id);
    final recommendationResult = await getTVSeriesRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _tvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tv) {
        _recommendationState = RequestState.Loading;
        _tv = tv;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (tv) {
            _recommendationState = RequestState.Loaded;
            _tvRecommendations = tv;
          },
        );
        _tvState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TVSeriesDetail tv) async {
    final result = await saveWatchListTv.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> removeFromWatchlist(TVSeriesDetail tv) async {
    final result = await removeWatchListTv.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListTvStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
