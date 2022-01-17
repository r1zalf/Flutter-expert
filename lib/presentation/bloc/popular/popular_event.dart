part of 'popular_bloc.dart';

abstract class PopularEvent extends Equatable {
  const PopularEvent();

  @override
  List<Object> get props => [];
}

class FetchPopularMovie extends PopularEvent {}


class FetchPopularTv extends PopularEvent {}

