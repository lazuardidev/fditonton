import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/search_tvseries.dart';
import 'package:ditonton/presentation/bloc/movie/search/search_movie_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_tvseries_event.dart';
part 'search_tvseries_state.dart';

class SearchTVSeriesBloc
    extends Bloc<SearchTVSeriesEvent, SearchTVSeriesState> {
  final SearchTVSeries _searchTVSeries;
  SearchTVSeriesBloc(this._searchTVSeries) : super(SearchTVSeriesEmpty()) {
    on<OnQueryChangedTVSeries>((event, emit) async {
      final query = event.query;
      emit(SearchTVSeriesLoading());
      final result = await _searchTVSeries.execute(query);
      result.fold(
        (failure) => emit(SearchTVSeriesError(failure.message)),
        (data) => emit(SearchTVSeriesSuccess(data)),
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
