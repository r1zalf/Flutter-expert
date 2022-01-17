part of 'detail_bloc.dart';

abstract class DetailState extends Equatable {
  const DetailState();
}

class DetailEmpty extends DetailState {
  @override
  List<Object?> get props => [];
}

class DetailLoading extends DetailState {
  @override
  List<Object?> get props => [];
}

class DetailError extends DetailState {
  final String message;

  DetailError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailHasDataMovie extends DetailState {
  final MovieDetail result;
  const DetailHasDataMovie(
      this.result);


  @override
  List<Object> get props => [result];
}


class DetailHasDataTv extends DetailState {
  final TvSeriesDetail result;

  DetailHasDataTv(this.result);

  @override
  List<Object> get props => [result];
}
