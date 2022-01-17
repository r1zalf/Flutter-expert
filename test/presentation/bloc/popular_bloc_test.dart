import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:ditonton/presentation/bloc/popular/popular_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies, GetPopularTvSeries])
void main() {
  late PopularBloc popularBloc;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    popularBloc = PopularBloc(mockGetPopularMovies, mockGetPopularTvSeries);
  });

  test(
    "initial state should be empty",
    () {
      expect(popularBloc.state, PopularEmpty());
    },
  );

  blocTest<PopularBloc, PopularState>(
    "Should emit [Loading, Error] when get popular movie is unsuccessful",
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return popularBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovie()),
    expect: () => [
      PopularLoading(),
      PopularError("Server Failure"),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );

  blocTest<PopularBloc, PopularState>(
    "Should emit [Loading, Error] when get popular tv series is unsuccessful",
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return popularBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTv()),
    wait: Duration(milliseconds: 500),
    expect: () => [
      PopularLoading(),
      PopularError("Server Failure"),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvSeries.execute());
    },
  );

  blocTest<PopularBloc, PopularState>(
    "Should emit [Loading, HasData] when data popular movie is gotten successfully",
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));

      return popularBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovie()),
    wait: Duration(milliseconds: 500),
    expect: () => [PopularLoading(), PopularHasDataMovie(testMovieList)],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );

  blocTest<PopularBloc, PopularState>(
    "Should emit [Loading, HasData] when data popular tv series is gotten successfully",
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tvSeriesList));

      return popularBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTv()),
    wait: Duration(milliseconds: 500),
    expect: () => [PopularLoading(), PopularHasDataTv(tvSeriesList)],
    verify: (bloc) {
      verify(mockGetPopularTvSeries.execute());
    },
  );
}
