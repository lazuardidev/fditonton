import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_top_rated_tvseries.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'top_rated_tvseries_event.dart';
part 'top_rated_tvseries_state.dart';

class TopRatedTVSeriesBloc
    extends Bloc<TopRatedTVSeriesEvent, TopRatedTVSeriesState> {
  final GetTopRatedTVSeries _getTopRatedTVSeries;
  TopRatedTVSeriesBloc(this._getTopRatedTVSeries)
      : super(TopRatedTVSeriesEmpty()) {
    on<LoadTopRatedTVSeries>((event, emit) async {
      emit(TopRatedTVSeriesLoading());
      final result = await _getTopRatedTVSeries.execute();
      result.fold(
        (failure) => emit(TopRatedTVSeriesError(failure.message)),
        (data) => emit(TopRatedTVSeriesSuccess(data)),
      );
    });
  }
}
