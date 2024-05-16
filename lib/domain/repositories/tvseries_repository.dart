import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries_detail.dart';

abstract class TVSeriesRepository {
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<TVSeries>>> getNowPlayingTVSeries();
  Future<Either<Failure, List<TVSeries>>> getPopularTVSeries();
  Future<Either<Failure, List<TVSeries>>> getTopRatedTVSeries();
  Future<Either<Failure, TVSeriesDetail>> getTVSeriesDetail(int id);
  Future<Either<Failure, List<TVSeries>>> getTVSeriesRecommendations(int id);
  Future<Either<Failure, List<TVSeries>>> searchTVSeries(String query);
  Future<Either<Failure, String>> saveWatchlistTVSeries(TVSeriesDetail tv);
  Future<Either<Failure, String>> removeWatchlistTVSeries(TVSeriesDetail tv);
  Future<bool> isAddedToWatchlistTVSeries(int id);
  Future<Either<Failure, List<TVSeries>>> getWatchlistTVSeries();
}
