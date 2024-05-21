import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_popular_tvseries.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'popular_tvseries_event.dart';
part 'popular_tvseries_state.dart';

class PopularTVSeriesBloc
    extends Bloc<PopularTVSeriesEvent, PopularTVSeriesState> {
  final GetPopularTVSeries _getPopularTVSeries;
  PopularTVSeriesBloc(this._getPopularTVSeries) : super(PopularTVSeriesEmpty()) {
    on<LoadPopularTVSeries>((event, emit) async {
      emit(PopularTVSeriesLoading());
      final result = await _getPopularTVSeries.execute();
      result.fold(
        (failure) => emit(PopularTVSeriesError(failure.message)),
        (data) => emit(PopularTVSeriesSuccess(data)),
      );
    });
  }
}
