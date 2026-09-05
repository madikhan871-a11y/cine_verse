class Movie {
  final int id;
  final String title;
  final String posterUrl;
  final String backdropUrl;
  final String description;
  final String genre;
  final String year;
  final String duration;
  final double rating;
  final String director;
  final List<String> cast;

  bool isFavorite;

  Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.backdropUrl,
    required this.description,
    required this.genre,
    required this.year,
    required this.duration,
    required this.rating,
    required this.director,
    required this.cast,
    this.isFavorite = false,
  });
}