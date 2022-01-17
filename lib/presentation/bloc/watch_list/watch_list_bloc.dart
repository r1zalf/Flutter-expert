import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'watch_list_event.dart';
part 'watch_list_state.dart';

class WatchListBloc extends Bloc<WatchListEvent, WatchListState> {
  final GetWatchlistMovies _getWatchListMovies;
  final GetWatchlistTvSeries _getWatchListTvSeries;

  WatchListBloc(
    this._getWatchListMovies,
    this._getWatchListTvSeries,
  ) : super(WatchListEmpty()) {
    on<FetchWatchListMovie>(
      (event, emit) async {
        emit(WatchListLoading());
        final result = await _getWatchListMovies.execute();
        result.fold(
          (failure) => emit(
            WatchListError(failure.message)
          ),
          (movies) => emit(
            WatchListHasDataMovie(movies),
          ),
        );
      },
    );

    on<FetchWatchListTv>(
      (event, emit) async {
        emit(WatchListLoading());
        final result = await _getWatchListTvSeries.execute();
        result.fold(
          (failure) => emit(
            WatchListError(failure.message),
          ),
          (tv) => emit(
            WatchListHasDataTv(tv),
          ),
        );
      },
    );
  }
}
