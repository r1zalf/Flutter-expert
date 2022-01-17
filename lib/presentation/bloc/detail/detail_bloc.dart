import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:equatable/equatable.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final GetMovieDetail _getMovieDetail;
  final GetTvSeriesDetail _getTvSeriesDetail;
  DetailBloc(
    this._getMovieDetail,
    this._getTvSeriesDetail,
  ) : super(DetailEmpty()) {
    on<FetchDetailMovie>((event, emit) async {
      emit(DetailLoading());
      final detailResult = await _getMovieDetail.execute(event.id);
      detailResult.fold(
        (failure) => emit(DetailError(failure.message)),
        (movie) => emit(DetailHasDataMovie(movie)),
      );
    });


    on<FetchDetailTvSeries>((event, emit) async {
      emit(DetailLoading());
      final detailResult = await _getTvSeriesDetail.execute(event.id);
      detailResult.fold(
        (failure) => emit(DetailError(failure.message)),
        (tv) => emit(DetailHasDataTv(tv)),
      );
    });
  }
}
