import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies _getPopularMovies;
  PopularMovieBloc(this._getPopularMovies) : super(PopularMovieInitial()) {
    on<LoadPopularMovie>((event, emit) async {
      emit(PopularMovieLoading());
      final result = await _getPopularMovies.execute();
      result.fold(
        (failure) => emit(PopularMovieError(failure.message)),
        (data) => emit(PopularMovieSuccess(data)),
      );
    });
  }
}
