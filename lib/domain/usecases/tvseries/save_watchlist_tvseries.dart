import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries_detail.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class SaveWatchListTVSeries {
  final TVSeriesRepository repository;

  SaveWatchListTVSeries(this.repository);

  Future<Either<Failure, String>> execute(TVSeriesDetail tv) {
    return repository.saveWatchlistTVSeries(tv);
  }
}
