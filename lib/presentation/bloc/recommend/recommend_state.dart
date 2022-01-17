part of 'recommend_bloc.dart';

abstract class RecommendState extends Equatable {
  const RecommendState();
  
  @override
  List<Object> get props => [];
}


class RecommendEmpty extends RecommendState {}
 
class RecommendLoading extends RecommendState {}
 
class RecommendError extends RecommendState {
  final String message;
 
  RecommendError(this.message);
 
  @override
  List<Object> get props => [message];
}
 
class RecommendHasDataMovie extends RecommendState {
  final List<Movie> result;
 
  RecommendHasDataMovie(this.result);
 
  @override
  List<Object> get props => [result];
}


class RecommendHasDataTv extends RecommendState {
  final List<TvSeries> result;
 
  RecommendHasDataTv(this.result);
 
  @override
  List<Object> get props => [result];
}


