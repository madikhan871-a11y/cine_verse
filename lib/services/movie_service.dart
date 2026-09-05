import '../data/movie_data.dart';
import '../models/movie_model.dart';

class MovieService {
  static List<Movie> getAllMovies() {
    return MovieData.movies;
  }

  static List<Movie> getTrendingMovies() {
    return MovieData.movies.take(6).toList();
  }

  static List<Movie> getPopularMovies() {
    final movies = [...MovieData.movies];

    movies.sort(
          (a, b) => b.rating.compareTo(a.rating),
    );

    return movies;
  }

  static List<Movie> searchMovies(String query) {
    if (query.trim().isEmpty) {
      return MovieData.movies;
    }

    final search = query.toLowerCase().trim();

    return MovieData.movies.where((movie) {
      return movie.title.toLowerCase().contains(search) ||
          movie.genre.toLowerCase().contains(search) ||
          movie.director.toLowerCase().contains(search);
    }).toList();
  }

  static List<Movie> filterByGenre(String genre) {
    if (genre == 'All') {
      return MovieData.movies;
    }

    return MovieData.movies
        .where((movie) => movie.genre == genre)
        .toList();
  }

  static List<Movie> getFavorites() {
    return MovieData.movies
        .where((movie) => movie.isFavorite)
        .toList();
  }

  static Movie? getMovieById(int id) {
    try {
      return MovieData.movies.firstWhere(
            (movie) => movie.id == id,
      );
    } catch (_) {
      return null;
    }
  }
}