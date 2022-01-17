import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/watch_list/watch_list_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';
  final isMovie;
  WatchlistMoviesPage(this.isMovie);

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  late WatchListBloc _watchListBloc;
  @override
  void initState() {
    super.initState();
    _watchListBloc = context.read<WatchListBloc>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    if (_watchListBloc.state is WatchListHasDataMovie) {
      _watchListBloc.add(FetchWatchListMovie());
    } else if (_watchListBloc.state is WatchListHasDataTv) {
      _watchListBloc.add(FetchWatchListTv());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchListBloc, WatchListState>(
          builder: (_, state) {
            if (state is WatchListLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchListHasDataMovie) {
              return ListView.builder(
                itemCount: state.result.length,
                itemBuilder: (context, index) {
                  return MovieCard(state.result[index]);
                },
              );
            } else if (state is WatchListHasDataTv) {
              return ListView.builder(
                itemCount: state.result.length,
                itemBuilder: (context, index) {
                  return TvCard(state.result[index]);
                },
              );
            } else if (state is WatchListError) {
              return Text('Failed');
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
