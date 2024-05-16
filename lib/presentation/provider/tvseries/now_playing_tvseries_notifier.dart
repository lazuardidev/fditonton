import 'package:ditonton/domain/usecases/tvseries/get_now_playing_tvseries.dart';
import 'package:flutter/material.dart';
import '../../../common/state_enum.dart';
import '../../../domain/entities/tvseries/tvseries.dart';

class NowPlayingTVSeriesNotifier extends ChangeNotifier {
  final GetNowPlayingTVSeries getNowPlayingTVSeries;

  NowPlayingTVSeriesNotifier(this.getNowPlayingTVSeries);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TVSeries> _tvSeries = [];
  List<TVSeries> get tvSeries => _tvSeries;

  String _message = '';
  String get message => _message;

  Future<void> fetchNowPlayingTVSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTVSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvSeriesData) {
        _tvSeries = tvSeriesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
