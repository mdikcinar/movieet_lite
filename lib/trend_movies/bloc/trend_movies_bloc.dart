import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

part 'trend_movies_event.dart';
part 'trend_movies_state.dart';

const _postLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class TrendMoviesBloc extends Bloc<TrendMoviesEvent, TrendMoviesState> {
  TrendMoviesBloc() : super(TrendMoviesInitial()) {
    on<TrendMoviesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
