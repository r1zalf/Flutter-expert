part of 'now_playing_bloc.dart';

abstract class NowPlayingState extends Equatable {
  const NowPlayingState();
  }




class NowPlayingEmpty extends NowPlayingState {
  @override
  List<Object?> get props => [];
}
 
class NowPlayingLoading extends NowPlayingState {
  @override
  List<Object?> get props =>  [];
}
 
class NowPlayingError extends NowPlayingState {
  final String message;
 
  NowPlayingError(this.message);
 
  @override
  List<Object> get props => [message];
}
 
class NowPlayingHasDataMovie extends NowPlayingState {
  final List<Movie> result;
 
  NowPlayingHasDataMovie(this.result);
 
  @override
  List<Object> get props => [result];
}


class NowPlayingHasDataTv extends NowPlayingState {
  final List<TvSeries> result;
 
  NowPlayingHasDataTv(this.result);
 
  @override
  List<Object> get props => [result];
}