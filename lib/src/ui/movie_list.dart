import 'package:flutter/material.dart';
import 'package:fluttermovieapp/src/blocs/movie_detail_bloc_provider.dart';
import 'package:fluttermovieapp/src/ui/movie_detail.dart';
import '../models/item_model.dart';
import '../blocs/movies_bloc.dart';

class MovieList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MovieListState();
  }
}

class _MovieListState extends State<MovieList> {

  //  Called when this object is inserted into the tree.
  //  Make our network call here
  @override
  void initState() {
    super.initState();
    bloc.fetchAllMovies();
  }

  //  Dispose any resources here
  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllMovies();
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: StreamBuilder(
        stream: bloc.allMovies,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  //  Our grid builder
  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.results.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: InkResponse(
              enableFeedback: true,
              child: Image.network(
                'https://image.tmdb.org/t/p/w185${snapshot.data
                    .results[index].posterPath}',
                fit: BoxFit.cover,
              ),
              onTap: () => openDetailPage(snapshot.data, index),
            ),
          );
        });
  }

  openDetailPage(ItemModel data, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return MovieDetailBlocProvider(
          child: MovieDetail(
          title: data.results[index].title,
          posterUrl: data.results[index].backdropPath,
          description: data.results[index].overview,
          releaseDate: data.results[index].releaseDate,
          voteAverage: data.results[index].voteAverage.toString(),
          movieId: data.results[index].id,
          ),
        );
      }),
    );
  }

}