import 'package:http/http.dart' as http;
import 'package:film_application/src/models/movie_model.dart';
import 'dart:async';
import "dart:convert";

class MoviesProvider {
  String _apikey = "3a0b4a3f6d736e93d5733388efbfc314";
  String _url = "api.themoviedb.org";
  String _language = "es-ES";

  int _popularPages = 0;

  List<Movie> _popular = new List();

  final _popularStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularSink => _popularStreamController.sink.add;

  Stream<List<Movie>> get popularStream => _popularStreamController.stream;

  void disposeStreams() {
    _popularStreamController?.close();
  }

  Future<List<Movie>> _processResponse(Uri url) async {
    final response = await http.get(url);

    final decodedData = json.decode(response.body);

    final movies = new Movies.fromJsonList(decodedData["results"]);

    return movies.items;
  }

  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(_url, "3/movie/now_playing", {
      "api_key": _apikey,
      "language": _language,
    });

    return await _processResponse(url);
  }

  Future<List<Movie>> getPopular() async {
    final url = Uri.https(_url, "3/movie/popular", {
      "api_key": _apikey,
      "language": _language,
      "page": _popularPages.toString(),
    });

    _popularPages++;

    final response = await _processResponse(url);

    _popular.addAll(response);
    popularSink(_popular);

    return response;
  }
}