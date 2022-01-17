
import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  final GetPopularMovies _getPopularMovies;
  final GetPopularTvSeries _getPopularTvSeries;

  PopularBloc(this._getPopularMovies, this._getPopularTvSeries)
      : super(PopularEmpty()) {
    on<FetchPopularMovie>(
      (event, emit) async {
        emit(PopularLoading());
        final result = await _getPopularMovies.execute();
        result.fold(
          (failure) => emit(
            PopularError(failure.message),
          ),
          (movies) => emit(
            PopularHasDataMovie(movies),
          ),
        );
      },
    );

    on<FetchPopularTv>(
      (event, emit) async {
        emit(PopularLoading());
        final result = await _getPopularTvSeries.execute();
        result.fold(
          (failure) => emit(
            PopularError(failure.message),
          ),
          (tv) => emit(
            PopularHasDataTv(tv),
          ),
        );
      },
    );
  }
}
