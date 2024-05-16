import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class GetTVSeriesRecommendation {
  final TVSeriesRepository repository;

  GetTVSeriesRecommendation(this.repository);

  Future<Either<Failure, List<TVSeries>>> execute(id) {
    return repository.getTVSeriesRecommendations(id);
  }
}
