part of 'detail_watch_list_bloc.dart';

abstract class DetailWatchListEvent extends Equatable {
  const DetailWatchListEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieStateWatchList extends DetailWatchListEvent {
  final int id;
  FetchMovieStateWatchList(this.id);
}

class AddMovieWatchList extends DetailWatchListEvent {
  final MovieDetail movieDetail;
  AddMovieWatchList(this.movieDetail);
}


class RemoveMovieWatchList extends DetailWatchListEvent {
  final MovieDetail movieDetail;
  RemoveMovieWatchList(this.movieDetail);
}



class FetchTvStateWatchList extends DetailWatchListEvent {
  final int id;
  FetchTvStateWatchList(this.id);
}


class AddTvWatchList extends DetailWatchListEvent {
  final TvSeriesDetail tvSeriesDetail;
  AddTvWatchList(this.tvSeriesDetail);
}



class RemoveTvWatchList extends DetailWatchListEvent {
  final TvSeriesDetail tvSeriesDetail;
  RemoveTvWatchList(this.tvSeriesDetail);
}




