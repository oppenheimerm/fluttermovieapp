import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/item_model.dart';

class MovieApiProvider {
  final _apiKey = '86d908b6a9ec37250f2614e8faf30f67';//'your-api-key';

  Future<ItemModel> fetchMovieList() async {
    print("entered");

    final response = await http.get(
        Uri.https(
            'api.themoviedb.org',
            '/3/movie/popular',
            {'api_key' : {_apiKey}}),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        });
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}