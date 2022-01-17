// Mocks generated by Mockito 5.0.16 from annotations
// in ditonton/test/presentation/bloc/detail_watch_list_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;

import 'package:dartz/dartz.dart' as _i4;
import 'package:ditonton/common/failure.dart' as _i9;
import 'package:ditonton/domain/entities/movie_detail.dart' as _i10;
import 'package:ditonton/domain/entities/tv_series_detail.dart' as _i12;
import 'package:ditonton/domain/repositories/movie_repository.dart' as _i2;
import 'package:ditonton/domain/repositories/tv_series_repository.dart' as _i3;
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart'
    as _i5;
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart' as _i13;
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart' as _i8;
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_status.dart'
    as _i7;
import 'package:ditonton/domain/usecases/tv_series/remove_watchlist.dart'
    as _i14;
import 'package:ditonton/domain/usecases/tv_series/save_watchlist.dart' as _i11;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeMovieRepository_0 extends _i1.Fake implements _i2.MovieRepository {}

class _FakeTvSeriesRepository_1 extends _i1.Fake
    implements _i3.TvSeriesRepository {}

class _FakeEither_2<L, R> extends _i1.Fake implements _i4.Either<L, R> {}

/// A class which mocks [GetWatchListStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListStatus extends _i1.Mock
    implements _i5.GetWatchListStatus {
  MockGetWatchListStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as _i2.MovieRepository);
  @override
  _i6.Future<bool> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<bool>.value(false)) as _i6.Future<bool>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [GetWatchTvListStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchTvListStatus extends _i1.Mock
    implements _i7.GetWatchTvListStatus {
  MockGetWatchTvListStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.TvSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvSeriesRepository_1()) as _i3.TvSeriesRepository);
  @override
  _i6.Future<bool> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<bool>.value(false)) as _i6.Future<bool>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [SaveWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlist extends _i1.Mock implements _i8.SaveWatchlist {
  MockSaveWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as _i2.MovieRepository);
  @override
  _i6.Future<_i4.Either<_i9.Failure, String>> execute(
          _i10.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#execute, [movie]),
              returnValue: Future<_i4.Either<_i9.Failure, String>>.value(
                  _FakeEither_2<_i9.Failure, String>()))
          as _i6.Future<_i4.Either<_i9.Failure, String>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [SaveWatchTvlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchTvlist extends _i1.Mock implements _i11.SaveWatchTvlist {
  MockSaveWatchTvlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.TvSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvSeriesRepository_1()) as _i3.TvSeriesRepository);
  @override
  _i6.Future<_i4.Either<_i9.Failure, String>> execute(
          _i12.TvSeriesDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#execute, [tv]),
              returnValue: Future<_i4.Either<_i9.Failure, String>>.value(
                  _FakeEither_2<_i9.Failure, String>()))
          as _i6.Future<_i4.Either<_i9.Failure, String>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [RemoveWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlist extends _i1.Mock implements _i13.RemoveWatchlist {
  MockRemoveWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as _i2.MovieRepository);
  @override
  _i6.Future<_i4.Either<_i9.Failure, String>> execute(
          _i10.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#execute, [movie]),
              returnValue: Future<_i4.Either<_i9.Failure, String>>.value(
                  _FakeEither_2<_i9.Failure, String>()))
          as _i6.Future<_i4.Either<_i9.Failure, String>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [RemoveWatchTvlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchTvlist extends _i1.Mock implements _i14.RemoveWatchTvlist {
  MockRemoveWatchTvlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.TvSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvSeriesRepository_1()) as _i3.TvSeriesRepository);
  @override
  _i6.Future<_i4.Either<_i9.Failure, String>> execute(
          _i12.TvSeriesDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#execute, [tv]),
              returnValue: Future<_i4.Either<_i9.Failure, String>>.value(
                  _FakeEither_2<_i9.Failure, String>()))
          as _i6.Future<_i4.Either<_i9.Failure, String>>);
  @override
  String toString() => super.toString();
}