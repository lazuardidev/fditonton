import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchlistMovies getWatchlistMovies;
  final GetWatchListStatus getWatchListStatus;
  WatchlistMovieBloc({
    required this.saveWatchlist,
    required this.removeWatchlist,
    required this.getWatchlistMovies,
    required this.getWatchListStatus,
  }) : super(WatchlistMovieInitial()) {
    on<LoadWatchListStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(WatchListStatusAdded(result));
    });

    on<LoadWatchListMovie>((event, emit) async {
      emit(WatchListMovieLoading());
      final result = await getWatchlistMovies.execute();
      result.fold(
        (failure) => emit(WatchListMovieError(failure.message)),
        (data) => emit(WatchListMovieSuccess(data)),
      );
    });

    on<AddWatchList>((event, emit) async {
      final result = await saveWatchlist.execute(event.movie);
      result.fold(
        (failure) => emit(FailedMessage(failure.message)),
        (data) => emit(SuccessMessage(data)),
      );
    });

    on<RemoveFromWatchList>((event, emit) async {
      final result = await removeWatchlist.execute(event.movie);
      result.fold(
        (faiure) => emit(FailedMessage(faiure.message)),
        (successMessage) => emit(SuccessMessage(successMessage)),
      );
    });
  }
}
