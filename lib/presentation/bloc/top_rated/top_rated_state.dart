part of 'top_rated_bloc.dart';

abstract class TopRatedState extends Equatable {
  const TopRatedState();

}


class TopRatedEmpty extends TopRatedState {
  @override
  List<Object?> get props => [];
}
 
class TopRatedLoading extends TopRatedState {
  @override
  List<Object?> get props => [];
}
 
class TopRatedError extends TopRatedState {
  final String message;
 
  TopRatedError(this.message);
 
  @override
  List<Object> get props => [message];
}
 
class TopRatedHasDataMovie extends TopRatedState {
  final List<Movie> result;
 
  TopRatedHasDataMovie(this.result);
 
  @override
  List<Object> get props => [result];
}


class TopRatedHasDataTv extends TopRatedState {
  final List<TvSeries> result;
 
  TopRatedHasDataTv(this.result);
 
  @override
  List<Object> get props => [result];
}
