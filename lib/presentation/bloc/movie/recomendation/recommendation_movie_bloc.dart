import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'recommendation_movie_event.dart';
part 'recommendation_movie_state.dart';

class RecommendationMovieBloc
    extends Bloc<RecommendationMovieEvent, RecommendationMovieState> {
  final GetRecommendationMovie _getRecommendationMovie;
  RecommendationMovieBloc(this._getRecommendationMovie)
      : super(RecommendationMovieInitial()) {
    on<LoadRecommendationMovie>((event, emit) async {
      emit(RecommendationMovieLoading());
      final result = await _getRecommendationMovie.execute(event.id);
      result.fold(
        (failure) => emit(RecommendationMovieError(failure.message)),
        (data) => emit(RecommendationMovieSuccess(data)),
      );
    });
  }
}
