import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/now_playing/now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/popular/popular_bloc.dart';
import 'package:ditonton/presentation/bloc/search/search_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated/top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/watch_list/watch_list_bloc.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/provider/movie/movie_list_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  late NowPlayingBloc _nowPlayingBloc;
  late PopularBloc _popularBloc;
  late TopRatedBloc _topRatedBloc;
  late WatchListBloc _watchListBloc;

  @override
  void initState() {
    super.initState();
    _nowPlayingBloc = context.read<NowPlayingBloc>();
    _popularBloc = context.read<PopularBloc>();
    _topRatedBloc = context.read<TopRatedBloc>();
    _watchListBloc = context.read<WatchListBloc>();

    _nowPlayingBloc.add(FetchNowPlayingMovie());
    _popularBloc.add(FetchPopularMovie());
    _topRatedBloc.add(FetchTopRatedMovie());

    // Future.microtask(
    //     () => Provider.of<MovieListNotifier>(context, listen: false)
    //       ..fetchNowPlayingMovies()
    //       ..fetchPopularMovies()
    //       ..fetchTopRatedMovies());
    // Future.microtask(
    //   () => Provider.of<TvSeriesNotifier>(context, listen: false)
    //     ..fetchNowPlayingTvSeries()
    //     ..fetchPopularTvSeries()
    //     ..fetchTopRatedTvSeries(),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                _nowPlayingBloc.add(FetchNowPlayingMovie());
                _popularBloc.add(FetchPopularMovie());
                _topRatedBloc.add(FetchTopRatedMovie());

                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('TV Series'),
              onTap: () {
                _nowPlayingBloc.add(FetchNowPlayingTv());
                _popularBloc.add(FetchPopularTv());
                _topRatedBloc.add(FetchTopRatedTv());

                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                _watchListBloc.add(FetchWatchListMovie());
                Navigator.pushNamed(
                  context,
                  WatchlistMoviesPage.ROUTE_NAME,
                  arguments: true,
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Tv Watchlist'),
              onTap: () {
                _watchListBloc.add(FetchWatchListTv());

                Navigator.pushNamed(
                  context,
                  WatchlistMoviesPage.ROUTE_NAME,
                  arguments: false,
                );
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<SearchBloc>().add(Clear());
              // Navigator.pushNamed(context, SearchPage.ROUTE_NAME,
              //     arguments: isMovie);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingBloc, NowPlayingState>(
                builder: (_, state) {
                  if (state is NowPlayingLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingHasDataMovie) {
                    return MovieList(state.result);
                  } else if (state is NowPlayingHasDataTv) {
                    return TvList(state.result);
                  } else if (state is NowPlayingError) {
                    return Text('Failed');
                  } else {
                    return SizedBox();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () {
                  Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME);
                },
              ),
              BlocBuilder<PopularBloc, PopularState>(
                builder: (_, state) {
                  if (state is PopularLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularHasDataMovie) {
                    return MovieList(state.result);
                  } else if (state is PopularHasDataTv) {
                    return TvList(state.result);
                  } else if (state is PopularError) {
                    return Text('Failed');
                  } else {
                    return SizedBox();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () {
                  Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME);
                },
              ),
              BlocBuilder<TopRatedBloc, TopRatedState>(
                builder: (_, state) {
                  if (state is TopRatedLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedHasDataMovie) {
                    return MovieList(state.result);
                  } else if (state is TopRatedHasDataTv) {
                    return TvList(state.result);
                  } else if (state is PopularError) {
                    return Text('Failed');
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeMovieContent extends StatelessWidget {
  const HomeMovieContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Now Playing',
              style: kHeading6,
            ),
            Consumer<MovieListNotifier>(builder: (context, data, child) {
              final state = data.nowPlayingState;
              if (state == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                return MovieList(data.nowPlayingMovies);
              } else {
                return Text('Failed');
              }
            }),
            _buildSubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
            ),
            Consumer<MovieListNotifier>(builder: (context, data, child) {
              final state = data.popularMoviesState;
              if (state == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                return MovieList(data.popularMovies);
              } else {
                return Text('Failed');
              }
            }),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
            ),
            Consumer<MovieListNotifier>(builder: (context, data, child) {
              final state = data.topRatedMoviesState;
              if (state == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                return MovieList(data.topRatedMovies);
              } else {
                return Text('Failed');
              }
            }),
          ],
        ),
      ),
    );
  }
}

Row _buildSubHeading({required String title, required Function() onTap}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: kHeading6,
      ),
      InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                'See More',
                style: TextStyle(color: Colors.white),
              ),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    ],
  );
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: {
                    "id": movie.id,
                    "isMovie": true,
                  },
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}

class TvList extends StatelessWidget {
  final List<TvSeries> tvSeriesList;

  TvList(this.tvSeriesList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvSeries = tvSeriesList[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: {
                    "id": tvSeries.id,
                    "isMovie": false,
                  },
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvSeries.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeriesList.length,
      ),
    );
  }
}
