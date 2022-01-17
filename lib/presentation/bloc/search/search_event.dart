part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

}

class OnQueryChangedMovie extends SearchEvent {
  final String query;
  OnQueryChangedMovie(this.query);

  @override
  List<Object?> get props => [query];
}


class OnQueryChangedTv extends SearchEvent {
  final String query;
  OnQueryChangedTv(this.query);

  @override
  List<Object?> get props => [query];
}

class Clear extends SearchEvent   {
  @override
  List<Object?> get props => [];
  
}