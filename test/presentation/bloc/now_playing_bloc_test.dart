import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:ditonton/presentation/bloc/now_playing/now_playing_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies, GetNowPlayingTvSeries])
void main() {
  late NowPlayingBloc nowPlayingBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    nowPlayingBloc = NowPlayingBloc(mockGetNowPlayingMovies, mockGetNowPlayingTvSeries);
  });

  test(
    "initial state should be empty",
    () {
      expect(nowPlayingBloc.state, NowPlayingEmpty());
    },
  );

  blocTest<NowPlayingBloc, NowPlayingState>(
    "Should emit [Loading, Error] when get now playing movie is unsuccessful",
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return nowPlayingBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingMovie()),
    expect: () => [
      NowPlayingLoading(),
      NowPlayingError("Server Failure"),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<NowPlayingBloc, NowPlayingState>(
    "Should emit [Loading, Error] when get now playing tv series is unsuccessful",
    build: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return nowPlayingBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingTv()),
    wait: Duration(milliseconds: 500),
    expect: () => [
      NowPlayingLoading(),
      NowPlayingError("Server Failure"),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvSeries.execute());
    },
  );

  blocTest<NowPlayingBloc, NowPlayingState>(
    "Should emit [Loading, HasData] when data now playing movie is gotten successfully",
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));

      return nowPlayingBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingMovie()),
    wait: Duration(milliseconds: 500),
    expect: () => [NowPlayingLoading(), NowPlayingHasDataMovie(testMovieList)],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<NowPlayingBloc, NowPlayingState>(
    "Should emit [Loading, HasData] when data now playing tv series is gotten successfully",
    build: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(tvSeriesList));

      return nowPlayingBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingTv()),
    wait: Duration(milliseconds: 500),
    expect: () => [NowPlayingLoading(), NowPlayingHasDataTv(tvSeriesList)],
    verify: (bloc) {
      verify(mockGetNowPlayingTvSeries.execute());
    },
  );
}
