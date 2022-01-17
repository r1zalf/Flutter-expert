import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:ditonton/presentation/bloc/detail/detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetTvSeriesDetail
])
main() {
  late DetailBloc detailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;

  setUp(
    () {
      mockGetMovieDetail = MockGetMovieDetail();
      mockGetTvSeriesDetail = MockGetTvSeriesDetail();

      detailBloc = DetailBloc(mockGetMovieDetail, mockGetTvSeriesDetail);
    },
  );
  test(
    'initial state should be empty',
    () {
      expect(detailBloc.state, DetailEmpty());
    },
  );

  blocTest<DetailBloc, DetailState>(
    "Should emit [Loading, Error] when get now detail movie is unsuccessful",
    build: () {
      when(mockGetMovieDetail.execute(1))
          .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));

      return detailBloc;
    },
    act: (bloc) => bloc.add(FetchDetailMovie(1)),
    expect: () => [
      DetailLoading(),
      DetailError("Database Failure"),
    ],
    verify: (bloc) => verify(mockGetMovieDetail.execute(1)),
  );

  blocTest<DetailBloc, DetailState>(
    "Should emit [Loading, HasData] when get now detail movie is Success",
    build: () {
      when(mockGetMovieDetail.execute(1))
          .thenAnswer((_) async => Right(testMovieDetail));

      return detailBloc;
    },
    act: (bloc) => bloc.add(FetchDetailMovie(1)),
    wait: Duration(milliseconds: 500),
    expect: () => [
      DetailLoading(),
      DetailHasDataMovie(testMovieDetail),
    ],
    verify: (bloc) => verify(mockGetMovieDetail.execute(1)),
  );



  blocTest<DetailBloc, DetailState>(
    "Should emit [Loading, Error] when get now detail tv is unsuccessful",
    build: () {
      when(mockGetTvSeriesDetail.execute(1))
          .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));

      return detailBloc;
    },
    act: (bloc) => bloc.add(FetchDetailTvSeries(1)),
    expect: () => [
      DetailLoading(),
      DetailError("Database Failure"),
    ],
    verify: (bloc) => verify(mockGetTvSeriesDetail.execute(1)),
  );

  blocTest<DetailBloc, DetailState>(
    "Should emit [Loading, HasData] when get now detail tv is Success",
    build: () {
      when(mockGetTvSeriesDetail.execute(1))
          .thenAnswer((_) async => Right(testTvDetailModel));

      return detailBloc;
    },
    act: (bloc) => bloc.add(FetchDetailTvSeries(1)),
    wait: Duration(milliseconds: 500),
    expect: () => [
      DetailLoading(),
      DetailHasDataTv(testTvDetailModel),
    ],
    verify: (bloc) => verify(mockGetTvSeriesDetail.execute(1)),
  );
}
