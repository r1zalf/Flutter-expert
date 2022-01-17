import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/tv_series/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/tv_series/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/detail_watch_list/detail_watch_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'detail_watch_list_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchListStatus,
  GetWatchTvListStatus,
  SaveWatchlist,
  SaveWatchTvlist,
  RemoveWatchlist,
  RemoveWatchTvlist,
])
void main() {
  late DetailWatchListBloc detailWatchListBloc;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockSaveWatchTvlist mockSaveWatchTvlist;
  late MockRemoveWatchTvlist mockRemoveWatchTvlist;
  late MockGetWatchTvListStatus mockGetWatchTvListStatus;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockGetWatchTvListStatus = MockGetWatchTvListStatus();
    mockSaveWatchTvlist = MockSaveWatchTvlist();
    mockRemoveWatchTvlist = MockRemoveWatchTvlist();

    detailWatchListBloc = DetailWatchListBloc(
      mockGetWatchListStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
      mockGetWatchTvListStatus,
      mockSaveWatchTvlist,
      mockRemoveWatchTvlist,
    );
  });

  test(
    "initial state should be empty",
    () {
      expect(detailWatchListBloc.state, DetailWatchListInit());
    },
  );

  blocTest<DetailWatchListBloc, DetailWatchListState>(
    "Should emit [Loading, HasData] when get state detail movie is Success",
    build: () {
      when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => true);
      return detailWatchListBloc;
    },
    act: (bloc) => bloc.add(FetchMovieStateWatchList(1)),
    expect: () => [
      DetailWatchListLoading(),
      DetailWatchListHasData(true),
    ],
    verify: (bloc) => mockGetWatchListStatus.execute(1),
  );

  blocTest<DetailWatchListBloc, DetailWatchListState>(
    "Should emit [Loading, HasData] when add movie to watchlist is Success",
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right("Added to Watchlist"));
      when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => true);
      return detailWatchListBloc;
    },
    act: (bloc) => bloc.add(AddMovieWatchList(testMovieDetail)),
    wait: Duration(milliseconds: 500),
    expect: () => [
      DetailWatchListLoading(),
      DetailWatchListHasData(true, message: "Added to Watchlist"),
    ],
    verify: (bloc) => {
      mockSaveWatchlist.execute(testMovieDetail),
      mockGetWatchListStatus.execute(1)
    },
  );

  blocTest<DetailWatchListBloc, DetailWatchListState>(
    "Should emit [Loading, HasData] when remove movie to watchlist is Success",
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right("Removed from Watchlist"));
      when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => false);
      return detailWatchListBloc;
    },
    act: (bloc) => bloc.add(RemoveMovieWatchList(testMovieDetail)),
    wait: Duration(milliseconds: 500),
    expect: () => [
      DetailWatchListLoading(),
      DetailWatchListHasData(false, message: "Removed from Watchlist"),
    ],
    verify: (bloc) => {
      mockRemoveWatchlist.execute(testMovieDetail),
      mockGetWatchListStatus.execute(1)
    },
  );


  blocTest<DetailWatchListBloc, DetailWatchListState>(
    "Should emit [Loading, HasData] when get state watch list tv is Success",
    build: () {
      when(mockGetWatchTvListStatus.execute(1)).thenAnswer((_) async => true);
      return detailWatchListBloc;
    },
    act: (bloc) => bloc.add(FetchTvStateWatchList(1)),
    expect: () => [
      DetailWatchListLoading(),
      DetailWatchListHasData(true),
    ],
    verify: (bloc) => mockGetWatchTvListStatus.execute(1),
  );


  blocTest<DetailWatchListBloc, DetailWatchListState>(
    "Should emit [Loading, HasData] when add tv to watchlist is Success",
    build: () {
      when(mockSaveWatchTvlist.execute(testTvDetail))
          .thenAnswer((_) async => Right("Added to Watchlist"));
      when(mockGetWatchTvListStatus.execute(1)).thenAnswer((_) async => true);
      return detailWatchListBloc;
    },
    act: (bloc) => bloc.add(AddTvWatchList(testTvDetail)),
    wait: Duration(milliseconds: 500),
    expect: () => [
      DetailWatchListLoading(),
      DetailWatchListHasData(true, message: "Added to Watchlist"),
    ],
    verify: (bloc) => {
      mockSaveWatchTvlist.execute(testTvDetail),
      mockGetWatchTvListStatus.execute(1)
    },
  );

  blocTest<DetailWatchListBloc, DetailWatchListState>(
    "Should emit [Loading, HasData] when remove tv to watchlist is Success",
    build: () {
      when(mockRemoveWatchTvlist.execute(testTvDetail))
          .thenAnswer((_) async => Right("Removed from Watchlist"));
      when(mockGetWatchTvListStatus.execute(1)).thenAnswer((_) async => false);
      return detailWatchListBloc;
    },
    act: (bloc) => bloc.add(RemoveTvWatchList(testTvDetail)),
    wait: Duration(milliseconds: 500),
    expect: () => [
      DetailWatchListLoading(),
      DetailWatchListHasData(false, message: "Removed from Watchlist"),
    ],
    verify: (bloc) => {
      mockRemoveWatchTvlist.execute(testTvDetail),
      mockGetWatchTvListStatus.execute(1)
    },
  );


}
