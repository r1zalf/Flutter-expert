import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:ditonton/domain/usecases/tv_series/search_tv_series.dart';
import 'package:ditonton/presentation/bloc/search/search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies, SearchTvSeries])
void main() {
  late SearchBloc searchBloc;
  late MockSearchMovies mockSearchMovies;
  late MockSearchTvSeries mockSearchTvSeries;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    mockSearchTvSeries = MockSearchTvSeries();

    searchBloc = SearchBloc(mockSearchMovies, mockSearchTvSeries);
  });

  test(
    "initial state should be empty",
    () {
      expect(searchBloc.state, SearchEmpty());
    },
  );

  blocTest<SearchBloc, SearchState>(
    "Should emit [Loading, Error] when get search movie is unsuccessful",
    build: () {
      when(mockSearchMovies.execute(testQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChangedMovie(testQuery)),
    wait: Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchError("Server Failure"),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(testQuery));
    }
  );


  blocTest<SearchBloc, SearchState>(
    "Should emit [Loading, Error] when get search tv series is unsuccessful",
    build: () {
      when(mockSearchTvSeries.execute(testQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChangedTv(testQuery)),
    wait: Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchError("Server Failure"),
    ],
    verify: (bloc) {
      verify(mockSearchTvSeries.execute(testQuery));
    }
  );


  blocTest<SearchBloc, SearchState>(
    "Should emit [Loading, HasData] when data search movie is gotten successfully",
    build: () {
      when(mockSearchMovies.execute(testQuery))
          .thenAnswer((_) async => Right(testMovieList));

      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChangedMovie(testQuery)),
    wait: Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchHasDataMovie(testMovieList)
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(testQuery));
    }
  );


  blocTest<SearchBloc, SearchState>(
    "Should emit [Loading, HasData] when data search tv series is gotten successfully",
    build: () {
      when(mockSearchTvSeries.execute(testQuery))
          .thenAnswer((_) async => Right(tvSeriesList));

      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChangedTv(testQuery)),
    wait: Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchHasDataTv(tvSeriesList)
    ],
    verify: (bloc) {
      verify(mockSearchTvSeries.execute(testQuery));
    }
  );
}

