import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
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
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // suggestions when the user type

    final suggestedList = query.isEmpty
        ? recentMovies
        : movies
            .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(
            suggestedList[index],
          ),
          onTap: () {},
        );
      },
      itemCount: suggestedList.length,
    );
  }
}
