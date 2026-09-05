import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/movie_model.dart';
import '../services/movie_service.dart';
import '../widgets/movie_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller =
  TextEditingController();

  List<Movie> results = MovieService.getAllMovies();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void search(String value) {
    setState(() {
      results = MovieService.searchMovies(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              20,
              20,
              15,
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Search Movies',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.tune_rounded,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: controller,
              onChanged: search,
              decoration: InputDecoration(
                hintText: 'Search title, genre, director...',
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppColors.textGrey,
                ),
                suffixIcon: controller.text.isNotEmpty
                    ? IconButton(
                  onPressed: () {
                    controller.clear();
                    search('');
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                  ),
                )
                    : null,
              ),
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: results.isEmpty
                ? _emptySearch()
                : GridView.builder(
              padding: const EdgeInsets.fromLTRB(
                20,
                5,
                20,
                25,
              ),
              itemCount: results.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 20,
                childAspectRatio: .58,
              ),
              itemBuilder: (_, index) {
                return MovieCard(
                  movie: results[index],
                  width: double.infinity,
                  onFavoriteChanged: () {
                    setState(() {});
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptySearch() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 85,
            height: 85,
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.search_off_rounded,
              size: 40,
              color: AppColors.textGrey,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'No movies found',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 7),
          const Text(
            'Try another movie title or genre.',
            style: TextStyle(
              color: AppColors.textGrey,
            ),
          ),
        ],
      ),
    );
  }
}