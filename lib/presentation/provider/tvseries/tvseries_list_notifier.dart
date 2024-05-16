import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_now_playing_tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_popular_tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_top_rated_tvseries.dart';
import 'package:flutter/cupertino.dart';

import '../../../common/state_enum.dart';

class TVSeriesListNotifier extends ChangeNotifier {
  var _nowPlayingTV = <TVSeries>[];
  List<TVSeries> get nowPlayingTv => _nowPlayingTV;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  var _popularTV = <TVSeries>[];
  List<TVSeries> get popularTv => _popularTV;

  RequestState _popularState = RequestState.Empty;
  RequestState get popularState => _popularState;

  var _topRatedTV = <TVSeries>[];
  List<TVSeries> get topRatedTV => _topRatedTV;

  RequestState _topRatedState = RequestState.Empty;
  RequestState get topRatedState => _topRatedState;

  String _message = '';
  String get message => _message;

  TVSeriesListNotifier({
    required this.getNowPlayingTVSeries,
    required this.getPopularTVSeries,
    required this.getTopRatedTVSeries,
  });

  final GetNowPlayingTVSeries getNowPlayingTVSeries;
  final GetPopularTVSeries getPopularTVSeries;
  final GetTopRatedTVSeries getTopRatedTVSeries;

  Future<void> fetchNowPlayingTV() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTVSeries.execute();
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlayingTV = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTV() async {
    _popularState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTVSeries.execute();
    result.fold(
      (failure) {
        _popularState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _popularState = RequestState.Loaded;
        _popularTV = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTV() async {
    _topRatedState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTVSeries.execute();
    result.fold(
      (failure) {
        _topRatedState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _topRatedState = RequestState.Loaded;
        _topRatedTV = tvData;
        notifyListeners();
      },
    );
  }
}
