import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/bloc/top_rated/top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies, GetTopRatedTvSeries])
void main() {
  late TopRatedBloc topRatedBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    topRatedBloc = TopRatedBloc(mockGetTopRatedMovies, mockGetTopRatedTvSeries);
  });

  test(
    "initial state should be empty",
    () {
      expect(topRatedBloc.state, TopRatedEmpty());
    },
  );

  blocTest<TopRatedBloc, TopRatedState>(
    "Should emit [Loading, Error] when get top rated movie is unsuccessful",
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return topRatedBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovie()),
    expect: () => [
      TopRatedLoading(),
      TopRatedError("Server Failure"),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );

  blocTest<TopRatedBloc, TopRatedState>(
    "Should emit [Loading, Error] when get top rated tv series is unsuccessful",
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return topRatedBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTv()),
    wait: Duration(milliseconds: 500),
    expect: () => [
      TopRatedLoading(),
      TopRatedError("Server Failure"),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvSeries.execute());
    },
  );

  blocTest<TopRatedBloc, TopRatedState>(
    "Should emit [Loading, HasData] when data top rated movie is gotten successfully",
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));

      return topRatedBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovie()),
    wait: Duration(milliseconds: 500),
    expect: () => [TopRatedLoading(), TopRatedHasDataMovie(testMovieList)],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );

  blocTest<TopRatedBloc, TopRatedState>(
    "Should emit [Loading, HasData] when data top rated tv series is gotten successfully",
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(tvSeriesList));

      return topRatedBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTv()),
    wait: Duration(milliseconds: 500),
    expect: () => [TopRatedLoading(), TopRatedHasDataTv(tvSeriesList)],
    verify: (bloc) {
      verify(mockGetTopRatedTvSeries.execute());
    },
  );
}
