import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries_detail.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_tvseries_status.dart';
import 'package:ditonton/domain/usecases/tvseries/remove_watchlist_tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/save_watchlist_tvseries.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tvseries_watchlist_event.dart';
part 'tvseries_watchlist_state.dart';

class TVSeriesWatchlistBloc
    extends Bloc<TVSeriesWatchlistEvent, TVSeriesWatchlistState> {
  final SaveWatchListTVSeries saveWatchListTVSeries;
  final RemoveWatchListTVSeries removeWatchListTVSeries;
  final GetWatchListTVSeriesStatus getWatchListTVSeriesStatus;
  final GetWatchListTVSeries getWatchListTVSeries;
  TVSeriesWatchlistBloc({
    required this.saveWatchListTVSeries,
    required this.removeWatchListTVSeries,
    required this.getWatchListTVSeriesStatus,
    required this.getWatchListTVSeries,
  }) : super(TVSeriesWatchlistInitial()) {
    on<AddWatchList>((event, emit) async {
      final result = await saveWatchListTVSeries.execute(event.tv);
      result.fold(
        (faiure) => emit(FailedMessage(faiure.message)),
        (successMessage) => emit(SuccessMessage(successMessage)),
      );
    });

    on<RemoveFromWatchList>((event, emit) async {
      final result = await removeWatchListTVSeries.execute(event.tv);
      result.fold(
        (faiure) => emit(FailedMessage(faiure.message)),
        (successMessage) => emit(SuccessMessage(successMessage)),
      );
    });

    on<LoadWatchListStatus>((event, emit) async {
      final result = await getWatchListTVSeriesStatus.execute(event.id);
      emit(WatchListStatusAdded(result));
    });

    on<LoadWatchListTVSeries>((event, emit) async {
      emit(TVSeriesWatchListLoading());
      final result = await getWatchListTVSeries.execute();
      result.fold(
        (failure) => emit(TVSeriesWatchListError(failure.message)),
        (data) => emit(TVSeriesWatchListSuccess(data)),
      );
    });
  }
}
