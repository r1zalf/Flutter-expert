part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  
  @override
  List<Object> get props => [];
}
class SearchEmpty extends SearchState {}
 
class SearchLoading extends SearchState {}
 
class SearchError extends SearchState {
  final String message;
 
  SearchError(this.message);
 
  @override
  List<Object> get props => [message];
}
 
class SearchHasDataMovie extends SearchState {
  final List<Movie> result;
 
  SearchHasDataMovie(this.result);
 
  @override
  List<Object> get props => [result];
}


class SearchHasDataTv extends SearchState {
  final List<TvSeries> result;
 
  SearchHasDataTv(this.result);
 
  @override
  List<Object> get props => [result];
}


