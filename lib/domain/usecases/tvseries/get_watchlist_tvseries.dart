import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';
import '../../../common/failure.dart';

class GetWatchListTVSeries {
  final TVSeriesRepository _repository;

  GetWatchListTVSeries(this._repository);

  Future<Either<Failure, List<TVSeries>>> execute() {
    return _repository.getWatchlistTVSeries();
  }
}
