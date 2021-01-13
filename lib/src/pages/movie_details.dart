import 'package:flutter/material.dart';

import 'package:film_application/src/models/actors_model.dart';
import 'package:film_application/src/models/movie_model.dart';

import 'package:film_application/src/providers/movies_provider.dart';

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
            _createCast(movie),
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
        Hero(
          tag: movie.uniqueId,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage(movie.getPosterImg()),
              height: 150.0,
            ),
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

  Widget _createCast(Movie movie) {
    final movieProvider = new MoviesProvider();

    return FutureBuilder(
      future: movieProvider.getCast(movie.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _createActorsPageView(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _createActorsPageView(List<Actor> actors) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        itemCount: actors.length,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1,
        ),
        itemBuilder: (context, index) => _actorCard(actors[index]),
      ),
    );
  }

  Widget _actorCard(Actor actor) {
    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage("assets/img/no-image.jpg"),
              image: NetworkImage(actor.getPhoto()),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
