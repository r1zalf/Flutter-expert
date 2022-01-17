part of 'recommend_bloc.dart';

abstract class RecommendEvent extends Equatable {
  const RecommendEvent();

  @override
  List<Object> get props => [];
}



class FetchRecommendMovie extends RecommendEvent {
  final id;
  FetchRecommendMovie(this.id);
}


class FetchRecommendTv extends RecommendEvent {
  final id;
  FetchRecommendTv(this.id);
}

