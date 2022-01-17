import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final GetNowPlayingMovies _getNowPlayingMovies;
  final GetNowPlayingTvSeries _getNowPlayingTvSeries;
  NowPlayingBloc(
    this._getNowPlayingMovies,
    this._getNowPlayingTvSeries,
  ) : super(NowPlayingEmpty()) {
    on<FetchNowPlayingMovie>(
      (event, emit) async {
        emit(NowPlayingLoading());
        final result = await _getNowPlayingMovies.execute();
        result.fold(
          (failure) => emit(
            NowPlayingError(failure.message),
          ),
          (movies) => emit(
            NowPlayingHasDataMovie(movies),
          ),
        );
      },
    );

    on<FetchNowPlayingTv>((event, emit) async {
      emit(NowPlayingLoading());
      final result = await _getNowPlayingTvSeries.execute();
      result.fold(
        (failure) => emit(
          NowPlayingError(failure.message),
        ),
        (tv) => emit(
          NowPlayingHasDataTv(tv),
        ),
      );
    });
  }
}
