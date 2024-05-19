import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchlistMovies getWatchlistMovies;
  final GetWatchListStatus getWatchListStatus;
  MovieWatchlistBloc({
    required this.saveWatchlist,
    required this.removeWatchlist,
    required this.getWatchlistMovies,
    required this.getWatchListStatus,
  }) : super(MovieWatchlistInitial()) {
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

    on<LoadWatchListStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(WatchListStatusAdded(result));
    });

    on<LoadWatchListMovie>((event, emit) async {
      emit(MovieWatchListLoading());
      final result = await getWatchlistMovies.execute();
      result.fold(
        (failure) => emit(MovieWatchListError(failure.message)),
        (data) => emit(MovieWatchListSuccess(data)),
      );
    });
  }
}
