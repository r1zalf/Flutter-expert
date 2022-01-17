import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:ditonton/domain/usecases/tv_series/search_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;
  final SearchTvSeries _searchTvSeries;

  SearchBloc(this._searchMovies, this._searchTvSeries) : super(SearchEmpty()) {
    on<OnQueryChangedMovie>(
      (event, emit) async {
        final query = event.query;
        emit(SearchLoading());

        final result = await _searchMovies.execute(query);

        result.fold(
          (failure) => emit(
            SearchError(failure.message),
          ),
          (movies) => emit(
            SearchHasDataMovie(movies),
          ),
        );
      },
      transformer: debounce(
        Duration(milliseconds: 500),
      ),
    );

     on<OnQueryChangedTv>(
      (event, emit) async {
        final query = event.query;
        emit(SearchLoading());

        final result = await _searchTvSeries.execute(query);

        result.fold(
           (failure) => emit(
            SearchError(failure.message),
          ),
          (tv) => emit(
            SearchHasDataTv(tv),
          ),
        );
      },
      transformer: debounce(
        Duration(milliseconds: 500),
      ),
    );

    on<Clear>((event, emit) => emit(SearchEmpty()));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
