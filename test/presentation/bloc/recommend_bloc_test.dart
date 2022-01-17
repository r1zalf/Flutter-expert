import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/tv_series/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/recommend/recommend_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'recommend_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieRecommendations,
  GetTvSeriesRecommendations,
])
void main() {
  late RecommendBloc recommendBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();

    recommendBloc = RecommendBloc(
        mockGetMovieRecommendations, mockGetTvSeriesRecommendations);
  });

  test("Initial state should be empty", () {
    expect(recommendBloc.state, RecommendEmpty());
  });

  blocTest<RecommendBloc, RecommendState>(
    "Should emit [Loading, Error] when get movie recommend is unsuccessful",
    build: () {
      when(mockGetMovieRecommendations.execute(1))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return recommendBloc;
    },
    act: (bloc) => bloc.add(FetchRecommendMovie(1)),
    expect: () => [
      RecommendLoading(),
      RecommendError("Server Failure"),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(1));
    },
  );

  blocTest<RecommendBloc, RecommendState>(
    "Should emit [Loading, Error] when get when get tv recommend is unsuccessful",
    build: () {
      when(mockGetTvSeriesRecommendations.execute(1))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return recommendBloc;
    },
    act: (bloc) => bloc.add(FetchRecommendTv(1)),
    wait: Duration(milliseconds: 500),
    expect: () => [
      RecommendLoading(),
      RecommendError("Server Failure"),
    ],
    verify: (_) {
      verify(mockGetTvSeriesRecommendations.execute(1));
    },
  );

  blocTest<RecommendBloc, RecommendState>(
    "Should emit [Loading, HasData] when data recommend movie is gotten successfully",
    build: () {
      when(mockGetMovieRecommendations.execute(1))
          .thenAnswer((_) async => Right(testMovieList));

      return recommendBloc;
    },
    act: (bloc) => bloc.add(FetchRecommendMovie(1)),
    wait: Duration(milliseconds: 500),
    expect: () => [
      RecommendLoading(),
      RecommendHasDataMovie(testMovieList),
    ],
    verify: (bloc) {
      verify(
        mockGetMovieRecommendations.execute(1),
      );
    },
  );

  blocTest<RecommendBloc, RecommendState>(
    "Should emit [Loading, HasData] when data recommend tv series is gotten successfully",
    build: () {
      when(mockGetTvSeriesRecommendations.execute(1))
          .thenAnswer((_) async => Right(tvSeriesList));

      return recommendBloc;
    },
    act: (bloc) => bloc.add(FetchRecommendTv(1)),
    wait: Duration(milliseconds: 500),
    expect: () => [
      RecommendLoading(),
      RecommendHasDataTv(tvSeriesList),
    ],
    verify: (_) {
      verify(mockGetTvSeriesRecommendations.execute(1));
    },
  );
}
