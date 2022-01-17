import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetWatchTvListStatus {
  final TvSeriesRepository repository;

  GetWatchTvListStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
