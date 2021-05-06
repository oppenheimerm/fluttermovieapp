import 'package:flutter/material.dart';
import 'movie_detail_bloc.dart';
export 'movie_detail_bloc.dart';

class MovieDetailBlocProvider extends InheritedWidget {

  final MovieDetailBloc bloc;

  MovieDetailBlocProvider({Key key, Widget child})
      : bloc = MovieDetailBloc(),
        super(key: key, child: child);

  //  The use of the "_", simply means the context argument in the builder
  //  is not used.  This method is used to check if any state had changed. If
  //  not, no reason to rebuild all widgets that rely on your state
  @override
  bool updateShouldNotify(_) {
    return true;
  }

  // This is the secret sauce. Write your own 'of' method that will behave
  // Exactly like MediaQuery.of and Theme.of.  It basically says 'get the
  // data from the widget of this type.
  static MovieDetailBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<MovieDetailBlocProvider>()).bloc;
  }
}