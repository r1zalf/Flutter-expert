import 'dart:io';

import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv_series/tv_series_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_series/tv_series_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:ditonton/domain/usecases/tv_series/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/tv_series/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/tv_series/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/popular/popular_bloc.dart';
import 'package:ditonton/presentation/bloc/search/search_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';

import 'common/custom_network.dart';
import 'domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'domain/usecases/tv_series/get_popular_tv_series.dart';
import 'domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'domain/usecases/tv_series/get_tv_series_detail.dart';
import 'domain/usecases/tv_series/get_watchlist_status.dart';
import 'domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'domain/usecases/tv_series/search_tv_series.dart';
import 'presentation/bloc/detail/detail_bloc.dart';
import 'presentation/bloc/detail_watch_list/detail_watch_list_bloc.dart';
import 'presentation/bloc/now_playing/now_playing_bloc.dart';
import 'presentation/bloc/recommend/recommend_bloc.dart';
import 'presentation/bloc/top_rated/top_rated_bloc.dart';
import 'presentation/bloc/watch_list/watch_list_bloc.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(
    () => SearchBloc(
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularBloc(
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
    () => NowPlayingBloc(
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedBloc(
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchListBloc(
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => DetailBloc(
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
    () => DetailWatchListBloc(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
    () => RecommendBloc(
      locator(),
      locator(),
    ),
  );
  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchTvListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchTvlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchTvlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
    () => TvSeriesRemoteDataSourceImpl(
      client: locator(),
    ),
  );
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
    () => TvSeriesLocalDataSourceImpl(
      databaseHelper: locator(),
    ),
  );

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => IOClient());
  locator.registerLazySingleton(() => HttpClient());

  locator.registerLazySingleton(() => CustomNetwork());
}
