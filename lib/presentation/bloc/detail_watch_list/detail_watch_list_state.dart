part of 'detail_watch_list_bloc.dart';

abstract class DetailWatchListState extends Equatable {
  const DetailWatchListState();

  @override
  List<Object> get props => [];
}

class DetailWatchListInit extends DetailWatchListState {}

class DetailWatchListLoading extends DetailWatchListState {}

class DetailWatchListHasData extends DetailWatchListState {
  final bool isWatchList;
  final String? message;

  DetailWatchListHasData(this.isWatchList, {this.message});
}

class DetailWatchListError extends DetailWatchListState {
  final String message;
  DetailWatchListError(this.message);
}
