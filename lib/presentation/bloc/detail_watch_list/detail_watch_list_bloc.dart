import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/tv_series/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/tv_series/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'detail_watch_list_event.dart';
part 'detail_watch_list_state.dart';

class DetailWatchListBloc
    extends Bloc<DetailWatchListEvent, DetailWatchListState> {
  GetWatchListStatus _getWatchListStatus;
  SaveWatchlist _saveWatchlist;
  RemoveWatchlist _removeWatchlist;
  GetWatchTvListStatus _getWatchTvListStatus;
  SaveWatchTvlist _saveWatchTvlist;
  RemoveWatchTvlist _removeWatchTvlist;

  DetailWatchListBloc(
    this._getWatchListStatus,
    this._saveWatchlist,
    this._removeWatchlist,
    this._getWatchTvListStatus,
    this._saveWatchTvlist,
    this._removeWatchTvlist,
  ) : super(DetailWatchListInit()) {
    on<FetchMovieStateWatchList>(fetchMovieStateWatchList);
    on<AddMovieWatchList>(addMovieWatchList);
    on<RemoveMovieWatchList>(removeMovieWatchList);
    on<FetchTvStateWatchList>(fetchTvStateWatchList);
    on<AddTvWatchList>(addTvWatchList);
    on<RemoveTvWatchList>(removeTvWatchList);
  }

  fetchMovieStateWatchList(FetchMovieStateWatchList event, emit) async {
    emit(DetailWatchListLoading());

    final status = await _getWatchListStatus.execute(event.id);

    emit(DetailWatchListHasData(status));
  }

  addMovieWatchList(AddMovieWatchList event, emit) async {
    emit(DetailWatchListLoading());

    final result = await _saveWatchlist.execute(event.movieDetail);
    final status = await _getWatchListStatus.execute(event.movieDetail.id);

    result.fold(
      (failure) => emit(DetailWatchListError(failure.message)),
      (success) => emit(DetailWatchListHasData(status, message: success)),
    );
  }

  removeMovieWatchList(RemoveMovieWatchList event, emit) async {
    emit(DetailWatchListLoading());

    final result = await _removeWatchlist.execute(event.movieDetail);
    final status = await _getWatchListStatus.execute(event.movieDetail.id);

    result.fold(
      (failure) => emit(DetailWatchListError(failure.message)),
      (success) => emit(DetailWatchListHasData(status, message: success)),
    );
  }

  fetchTvStateWatchList(FetchTvStateWatchList event, emit) async {
    emit(DetailWatchListLoading());

    final status = await _getWatchTvListStatus.execute(event.id);

    emit(DetailWatchListHasData(status));
  }

  addTvWatchList(AddTvWatchList event, emit) async {
    emit(DetailWatchListLoading());

    final result = await _saveWatchTvlist.execute(event.tvSeriesDetail);
    final status = await _getWatchTvListStatus.execute(event.tvSeriesDetail.id);

    result.fold(
      (failure) => emit(DetailWatchListError(failure.message)),
      (success) => emit(DetailWatchListHasData(status, message: success)),
    );
  }

  removeTvWatchList(RemoveTvWatchList event, emit) async {
    emit(DetailWatchListLoading());

    final result = await _removeWatchTvlist.execute(event.tvSeriesDetail);
    final status = await _getWatchTvListStatus.execute(event.tvSeriesDetail.id);

    result.fold(
      (failure) => emit(DetailWatchListError(failure.message)),
      (success) => emit(DetailWatchListHasData(status, message: success)),
    );
  }
}
