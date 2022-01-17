part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class FetchDetailMovie extends DetailEvent {
  final int id;
  const FetchDetailMovie(this.id);

  @override
  List<Object> get props => [id];
}

class FetchDetailTvSeries extends DetailEvent {
  final int id;
  const FetchDetailTvSeries(this.id);

  @override
  List<Object> get props => [id];
}
