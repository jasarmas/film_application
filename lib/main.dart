import 'package:film_application/src/pages/movie_details.dart';
import 'package:flutter/material.dart';

import 'package:film_application/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      initialRoute: "/",
      routes: {
        "/": (BuildContext context) => HomePage(),
        "details": (BuildContext context) => MovieDetails(),
      },
    );
  }
}
