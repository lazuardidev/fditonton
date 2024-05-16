import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class GetWatchListTVSeriesStatus {
  final TVSeriesRepository repository;

  GetWatchListTVSeriesStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlistTVSeries(id);
  }
}
