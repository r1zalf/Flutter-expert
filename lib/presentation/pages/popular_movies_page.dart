import 'package:ditonton/presentation/bloc/popular/popular_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesPage extends StatelessWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularBloc, PopularState>(
          builder: (_, state) {
            if (state is PopularLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularHasDataMovie) {
              return ListView.builder(
                itemCount: state.result.length,
                itemBuilder: (context, index) {
                  return MovieCard(state.result[index]);
                },
              );
            } else if (state is PopularHasDataTv) {
              return ListView.builder(
                itemCount: state.result.length,
                itemBuilder: (context, index) {
                  return TvCard(state.result[index]);
                },
              );
            } else if (state is PopularError) {
              return Text('Failed');
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
