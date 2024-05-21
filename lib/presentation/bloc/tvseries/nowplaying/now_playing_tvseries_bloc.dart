import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_now_playing_tvseries.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'now_playing_tvseries_event.dart';
part 'now_playing_tvseries_state.dart';

class NowPlayingTVSeriesBloc
    extends Bloc<NowPlayingTVSeriesEvent, NowPlayingTVSeriesState> {
  final GetNowPlayingTVSeries _getNowPlayingTVSeries;
  NowPlayingTVSeriesBloc(this._getNowPlayingTVSeries)
      : super(NowPlayingTVSeriesEmpty()) {
    on<LoadNowPlayingTVSeries>((event, emit) async {
      emit(NowPlayingTVSeriesLoading());
      final result = await _getNowPlayingTVSeries.execute();
      result.fold(
        (failure) => emit(NowPlayingTVSeriesError(failure.message)),
        (data) => emit(NowPlayingTVSeriesSuccess(data)),
      );
    });
  }
}
