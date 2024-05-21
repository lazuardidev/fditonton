import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'detail_movie_event.dart';
part 'detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final GetDetailMovie _getDetailMovie;
  DetailMovieBloc(this._getDetailMovie) : super(DetailMovieInitial()) {
    on<LoadDetailMovie>((event, emit) async {
      emit(DetailMovieLoading());
      final result = await _getDetailMovie.execute(event.id);
      result.fold(
        (failure) => emit(DetailMovieError(failure.message)),
        (data) => emit(DetailMovieSuccess(data)),
      );
    });
  }
}
