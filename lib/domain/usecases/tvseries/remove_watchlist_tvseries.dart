import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries_detail.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class RemoveWatchListTVSeries {
  final TVSeriesRepository repository;

  RemoveWatchListTVSeries(this.repository);

  Future<Either<Failure, String>> execute(TVSeriesDetail tv) {
    return repository.removeWatchlistTVSeries(tv);
  }
}
