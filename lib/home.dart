import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movie_rest_api/model/movie_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<MovieModel> movieModelList = <MovieModel>[];
  bool isLoading = true;
  getMovieData() async {
    String url =
        "https://api.themoviedb.org/3/trending/all/day?api_key={api_key}";
    Response response = await get(
      Uri.parse(url),
    );

    Map data = jsonDecode(response.body);
    // print(data);

    setState(() {
      data["results"].forEach((element) {
        MovieModel movieModel = MovieModel();
        movieModel = MovieModel.fromMap(element);
        movieModelList.add(movieModel);
        setState(() {
          isLoading = false;
        });
      });
    });

    // movieModelList.forEach((element) {
    //   print(element.title);
    // });
  }

  @override
  void initState() {
    super.initState();
    getMovieData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          "Movie Trending",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.amberAccent,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              //  physics: NeverScrollableScrollPhysics(),
              itemCount: movieModelList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.teal,
                    child: Text(
                      movieModelList[index].id.toString().substring(0, 2),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    movieModelList[index].title,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    movieModelList[index].popularity.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }),
    );
  }
}
