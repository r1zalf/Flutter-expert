import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'package:ditonton/presentation/bloc/watch_list/watch_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import 'watch_list_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies, GetWatchlistTvSeries])
void main() {
  late WatchListBloc nowPlayingBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    nowPlayingBloc =
        WatchListBloc(mockGetWatchlistMovies, mockGetWatchlistTvSeries);
  });

  test(
    "initial state should be empty",
    () {
      expect(nowPlayingBloc.state, WatchListEmpty());
    },
  );

  blocTest<WatchListBloc, WatchListState>(
    "Should emit [Loading, Error] when get watchlist movie is unsuccessful",
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));

      return nowPlayingBloc;
    },
    act: (bloc) => bloc.add(FetchWatchListMovie()),
    expect: () => [
      WatchListLoading(),
      WatchListError("Database Failure"),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchListBloc, WatchListState>(
    "Should emit [Loading, Error] when get watchlist tv series is unsuccessful",
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));

      return nowPlayingBloc;
    },
    act: (bloc) => bloc.add(FetchWatchListTv()),
    wait: Duration(milliseconds: 500),
    expect: () => [
      WatchListLoading(),
      WatchListError("Database Failure"),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvSeries.execute());
    },
  );

  blocTest<WatchListBloc, WatchListState>(
    "Should emit [Loading, HasData] when data watchlist movie is gotten successfully",
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));

      return nowPlayingBloc;
    },
    act: (bloc) => bloc.add(FetchWatchListMovie()),
    wait: Duration(milliseconds: 500),
    expect: () => [
      WatchListLoading(),
      WatchListHasDataMovie(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchListBloc, WatchListState>(
    "Should emit [Loading, HasData] when data watchlist tv series is gotten successfully",
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Right(tvSeriesList));

      return nowPlayingBloc;
    },
    act: (bloc) => bloc.add(FetchWatchListTv()),
    wait: Duration(milliseconds: 500),
    expect: () => [
      WatchListLoading(),
      WatchListHasDataTv(tvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvSeries.execute());
    },
  );
}
