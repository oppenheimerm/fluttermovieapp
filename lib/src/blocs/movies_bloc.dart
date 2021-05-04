import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';

class MoviesBloc {
  //  Create a Repository class instance for access
  //  to the fetchAllMovies().
  final _repository = Repository();
  //  PublishSubject - Exactly like a normal broadcast StreamController
  //  with one exception: this class is both a Stream and Sink.
  final _moviesFetcher = PublishSubject<ItemModel>();

  //  To pass the ItemModel object as stream we have to create another method:
  // allMovies(), whose return type is Observable
  Stream<ItemModel> get allMovies => _moviesFetcher.stream;

  //  The below is deprecated
  //Observable<ItemModel> get allMovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    ItemModel itemModel = await _repository.fetchAllMovies();
    _moviesFetcher.sink.add(itemModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}

//  Give access to this single instance of the MoviesBloc class to the
//  UI screen.
final bloc = MoviesBloc();