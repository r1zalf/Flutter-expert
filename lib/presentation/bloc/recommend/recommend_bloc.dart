import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/tv_series/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'recommend_event.dart';
part 'recommend_state.dart';

class RecommendBloc extends Bloc<RecommendEvent, RecommendState> {
  GetMovieRecommendations _getMovieRecommendations;
  GetTvSeriesRecommendations _getTvSeriesRecommendations;

  RecommendBloc(
    this._getMovieRecommendations,
    this._getTvSeriesRecommendations,
  ) : super(RecommendEmpty()) {
    on<FetchRecommendMovie>(
      (event, emit) async {
        emit(RecommendLoading());
        final result = await _getMovieRecommendations.execute(event.id);
        result.fold(
          (failure) => emit(
            RecommendError(failure.message),
          ),
          (movies) => emit(
            RecommendHasDataMovie(movies),
          ),
        );
      },
    );

    on<FetchRecommendTv>(
      (event, emit) async {
        emit(RecommendLoading());
        final result = await _getTvSeriesRecommendations.execute(event.id);
        result.fold(
          (failure) => emit(
            RecommendError(failure.message),
          ),
          (tv) => emit(
            RecommendHasDataTv(tv),
          ),
        );
      },
    );
  }
}
