part of 'watch_list_bloc.dart';

abstract class WatchListEvent extends Equatable {
  const WatchListEvent();

  @override
  List<Object> get props => [];
}



class FetchWatchListMovie extends WatchListEvent {}


class FetchWatchListTv extends WatchListEvent {}