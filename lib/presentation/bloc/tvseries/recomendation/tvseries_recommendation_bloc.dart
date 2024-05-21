import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tvseries_recommendation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tvseries_recommendation_event.dart';
part 'tvseries_recommendation_state.dart';

class TVSeriesRecommendationBloc
    extends Bloc<TVSeriesRecommendationEvent, TVSeriesRecommendationState> {
  final GetTVSeriesRecommendation _getTVSeriesRecommendation;
  TVSeriesRecommendationBloc(this._getTVSeriesRecommendation)
      : super(TVSeriesRecommendationEmpty()) {
    on<LoadTVSeriesRecommendations>((event, emit) async {
      emit(TVSeriesRecommendationLoading());
      final result = await _getTVSeriesRecommendation.execute(event.id);
      result.fold(
        (failure) => emit(TVSeriesRecommendationError(failure.message)),
        (data) => emit(TVSeriesRecommendationsSuccess(data)),
      );
    });
  }
}
