part of 'watch_list_bloc.dart';

abstract class WatchListState extends Equatable {
  const WatchListState();
  
}

class WatchListEmpty extends WatchListState {
  @override
  List<Object?> get props => [];
}
 
class WatchListLoading extends WatchListState {
  @override
  List<Object?> get props => [];
}
 
class WatchListError extends WatchListState {
  final String message;
 
  WatchListError(this.message);
 
  @override
  List<Object> get props => [message];
}
 
class WatchListHasDataMovie extends WatchListState {
  final List<Movie> result;
 
  WatchListHasDataMovie(this.result);
 
  @override
  List<Object> get props => [result];
}


class WatchListHasDataTv extends WatchListState {
  final List<TvSeries> result;
 
  WatchListHasDataTv(this.result);
 
  @override
  List<Object> get props => [result];
}

