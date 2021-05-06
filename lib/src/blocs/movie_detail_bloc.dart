import 'dart:async';

import 'package:rxdart/rxdart.dart';
import '../models/trailer_model.dart';
import '../resources/repository.dart';

class MovieDetailBloc {
  final _repository = Repository();
  //  Publish subject
  //  This Subject allows sending data, error and done events to the listener.
  final _movieId = PublishSubject<int>();
  //  A special StreamController that captures the latest item that has been
  //  added to the controller, and emits that as the first item to any new
  //  listener.
  final _trailers = BehaviorSubject<Future<TrailerModel>>();

  Function(int) get fetchTrailersById => _movieId.sink.add;
  Stream<Future<TrailerModel>> get movieTrailers => _trailers.stream;

  MovieDetailBloc() {
    _movieId.stream.transform(_itemTransformer()).pipe(_trailers);
  }

  dispose() async {
    _movieId.close();
    await _trailers.drain();
    _trailers.close();
  }

  _itemTransformer() {
    return ScanStreamTransformer(
          (Future<TrailerModel> trailer, int id, int index) {
        print(index);
        trailer = _repository .fetchTrailers(id);
        return trailer;
      },
    );
  }
}