class MovieModel {
  late int id;
  late String title;
  late String posterPath;
  late num popularity;

  MovieModel({
    this.id = 1,
    this.popularity = 1.2344,
    this.posterPath = "Image ",
    this.title = "Movies",
  });

  factory MovieModel.fromMap(Map movie) {
    return MovieModel(
      id: movie['id'] ?? "",
      popularity: movie['popularity'] ?? "",
      posterPath: movie['posterPath'] ?? "",
      title: movie['title'] ?? "",
    );
  }
}
