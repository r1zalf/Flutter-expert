import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'package:flutter/foundation.dart';

class WatchlistTvNotifier extends ChangeNotifier {
  var _watchlistTvSeriess = <TvSeries>[];
  List<TvSeries> get watchlistTvSeriess => _watchlistTvSeriess;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistTvNotifier({required this.getWatchlistTvSeriess});

  final GetWatchlistTvSeries getWatchlistTvSeriess;

  Future<void> fetchWatchlistTvSeriess() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTvSeriess.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriessData) {
        _watchlistState = RequestState.Loaded;
        _watchlistTvSeriess = tvSeriessData;
        notifyListeners();
      },
    );
  }
}
