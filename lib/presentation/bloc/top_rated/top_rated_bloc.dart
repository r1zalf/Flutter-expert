import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_event.dart';
part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final GetTopRatedMovies _getTopRatedMovies;
  final GetTopRatedTvSeries _getTopRatedTvSeries;
  TopRatedBloc(
    this._getTopRatedMovies,
    this._getTopRatedTvSeries,
  ) : super(TopRatedEmpty()) {
    on<FetchTopRatedMovie>(
      (event, emit) async {
        emit(TopRatedLoading());
        final result = await _getTopRatedMovies.execute();
        result.fold(
          (failure) => emit(
            TopRatedError(failure.message),
          ),
          (movies) => emit(
            TopRatedHasDataMovie(movies),
          ),
        );
      },
    );

    on<FetchTopRatedTv>(
      (event, emit) async {
        emit(TopRatedLoading());
        final result = await _getTopRatedTvSeries.execute();
        result.fold(
          (failure) => emit(
            TopRatedError(failure.message),
          ),
          (tv) => emit(
            TopRatedHasDataTv(tv),
          ),
        );
      },
    );
  }
}
