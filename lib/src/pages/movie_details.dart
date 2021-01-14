import 'package:flutter/material.dart';
import 'package:film_application/src/models/movie_model.dart';

class MovieDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _createAppbar(movie),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 10.0,
            ),
            _postTitle(movie, context),
            _description(movie),
            _description(movie),
            _description(movie),
            _description(movie),
            _description(movie),
            _description(movie),
            _description(movie),
          ]))
        ],
      ),
    );
  }

  Widget _createAppbar(Movie movie) {
    return SliverAppBar(
        elevation: 2.0,
        backgroundColor: Colors.indigoAccent,
        expandedHeight: 200.0,
        floating: false,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(movie.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              )),
          background: FadeInImage(
            image: NetworkImage(movie.getBackgroundImage()),
            placeholder: AssetImage("assets/img/loading.gif"),
            //fadeInDuration: Duration(microseconds: 300),
            fit: BoxFit.cover,
          ),
        ));
  }

  Widget _postTitle(Movie movie, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image(
            image: NetworkImage(movie.getPosterImg()),
            height: 150.0,
          ),
        ),
        Flexible(
            child: Container(
          padding: EdgeInsets.only(left: 15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              movie.title,
              style: Theme.of(context).textTheme.headline6,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              movie.originalTitle,
              style: Theme.of(context).textTheme.subtitle1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(children: [
              Icon(Icons.star_border),
              Text(
                movie.voteAverage.toString(),
                style: Theme.of(context).textTheme.subtitle1,
              )
            ]),
          ]),
        ))
      ]),
    );
  }

  Widget _description(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0,
      ),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
