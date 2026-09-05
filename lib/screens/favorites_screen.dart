import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../services/movie_service.dart';
import '../widgets/movie_card.dart';

class FavoritesScreen extends StatefulWidget {
  final VoidCallback? onChanged;

  const FavoritesScreen({
    super.key,
    this.onChanged,
  });

  @override
  State<FavoritesScreen> createState() =>
      _FavoritesScreenState();
}

class _FavoritesScreenState
    extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final favorites = MovieService.getFavorites();

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              20,
              20,
              5,
            ),
            child: Text(
              'My Favorites',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Movies you want to watch again',
              style: TextStyle(
                color: AppColors.textGrey,
                fontSize: 13,
              ),
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: favorites.isEmpty
                ? _emptyState()
                : GridView.builder(
              padding: const EdgeInsets.fromLTRB(
                20,
                5,
                20,
                25,
              ),
              itemCount: favorites.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 20,
                childAspectRatio: .58,
              ),
              itemBuilder: (_, index) {
                return MovieCard(
                  movie: favorites[index],
                  width: double.infinity,
                  onFavoriteChanged: () {
                    setState(() {});
                    widget.onChanged?.call();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 95,
              height: 95,
              decoration: BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border_rounded,
                color: AppColors.primary,
                size: 45,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'No Favorites Yet',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tap the heart icon on any movie to save it here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textGrey,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}