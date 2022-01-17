part of 'popular_bloc.dart';

abstract class PopularState extends Equatable {
  
}
class PopularEmpty extends PopularState {
  @override
  List<Object?> get props => [];
}
 
class PopularLoading extends PopularState {
  @override
  List<Object?> get props =>  [];
}
 
class PopularError extends PopularState {
  final String message;
 
  PopularError(this.message);
 
  @override
  List<Object> get props => [message];
}
 
class PopularHasDataMovie extends PopularState {
  final List<Movie> result;
 
  PopularHasDataMovie(this.result);
 
  @override
  List<Object> get props => [result];
}


class PopularHasDataTv extends PopularState {
  final List<TvSeries> result;
 
  PopularHasDataTv(this.result);
 
  @override
  List<Object> get props => [result];
}