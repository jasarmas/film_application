import 'package:film_application/src/models/movie_model.dart';
import 'package:film_application/src/providers/movies_provider.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  String selected = "";

  final moviesProvider = new MoviesProvider();

  final movies = [
    "wonder woman",
    "soul",
    "cosmoball",
    "astroman",
    "avengers",
    "el niño de pijama",
  ];

  final recentMovies = [
    "los croods",
    "kardashian",
    "shadow",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Appbar actions
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Appbar icon at the right side
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // create results that we are going to show
    return Center(
        child: Container(
      height: 100.0,
      width: 100.0,
      color: Colors.blueAccent,
      child: Text(selected),
    ));
  }

  //@override
  //Widget buildSuggestions(BuildContext context) {
  //  // suggestions when the user type
//
  //  final suggestedList = query.isEmpty
  //      ? recentMovies
  //      : movies
  //          .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
  //          .toList();
  //  return ListView.builder(
  //    itemBuilder: (context, index) {
  //      return ListTile(
  //        leading: Icon(Icons.movie),
  //        title: Text(
  //          suggestedList[index],
  //        ),
  //        onTap: () {
  //          selected = suggestedList[index];
  //          showResults(context);
  //        },
  //      );
  //    },
  //    itemCount: suggestedList.length,
  //  );
  //}
  @override
  Widget buildSuggestions(BuildContext context) {
    // suggestions when the user type
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data;
          return ListView(
              children: movies.map((movie) {
            return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(movie.getPosterImg()),
                  placeholder: AssetImage("assets/img/no-image.jpg"),
                  fit: BoxFit.contain,
                  width: 50.0,
                ),
                title: Text(movie.title),
                subtitle: Text(movie.originalTitle),
                onTap: () {
                  close(context, null);
                  movie.uniqueId = "";
                  Navigator.pushNamed(context, "details", arguments: movie);
                });
          }).toList());
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
