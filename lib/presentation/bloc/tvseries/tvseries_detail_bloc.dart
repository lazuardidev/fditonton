
import 'package:ditonton/domain/entities/tvseries/tvseries_detail.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tvseries_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'tvseries_detail_event.dart';
part 'tvseries_detail_state.dart';

class TVSeriesDetailBloc
    extends Bloc<TVSeriesDetailEvent, TVSeriesDetailState> {
  final GetTVSeriesDetail getTVSeriesDetail;

  TVSeriesDetailBloc(this.getTVSeriesDetail) : super(TVSeriesDetailEmpty()) {
    on<LoadTVSeriesDetail>((event, emit) async {
      emit(TVSeriesDetailLoading());
      final result = await getTVSeriesDetail.execute(event.id);
      result.fold(
        (failure) => emit(TVSeriesDetailError(failure.message)),
        (data) => emit(TVSeriesDetailSuccess(result: data)),
      );
    });
  }
}
