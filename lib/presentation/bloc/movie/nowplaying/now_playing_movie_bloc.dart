import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'now_playing_movie_event.dart';
part 'now_playing_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies _getNowPlayingMovies;
  NowPlayingMovieBloc(this._getNowPlayingMovies)
      : super(NowPlayingMovieInitial()) {
    on<LoadNowPlayingMovie>((event, emit) async {
      emit(NowPlayingMovieLoading());
      final result = await _getNowPlayingMovies.execute();
      result.fold(
        (failure) => emit(NowPlayingMovieError(failure.message)),
        (data) => emit(NowPlayingMovieSuccess(data)),
      );
    });
  }
}
