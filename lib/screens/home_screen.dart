import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import '../models/movie_model.dart';
import '../services/movie_service.dart';
import '../widgets/genre_chip.dart';
import '../widgets/movie_card.dart';
import '../widgets/section_title.dart';
import 'favorites_screen.dart';
import 'movie_detail_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  String selectedGenre = 'All';

  // Full-width featured cards.
  // viewportFraction: 1.0 prevents the next card from appearing
  // from the side.
  final PageController _featuredController = PageController(
    viewportFraction: 1.0,
  );

  @override
  void dispose() {
    _featuredController.dispose();
    super.dispose();
  }

  void refresh() {
    if (!mounted) return;

    setState(() {});
  }

  void openMovie(Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailScreen(movie: movie),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildHome(),
      const SearchScreen(),
      FavoritesScreen(onChanged: refresh),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_rounded),
            selectedIcon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border_rounded),
            selectedIcon: Icon(Icons.favorite_rounded),
            label: 'Favorites',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildHome() {
    final filteredMovies = MovieService.filterByGenre(selectedGenre);
    final trending = MovieService.getTrendingMovies();
    final topRated = MovieService.getPopularMovies();

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // ---------------------------------------------------------
          // HEADER
          // ---------------------------------------------------------
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                18,
                20,
                0,
              ),
              child: Row(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.primary,
                          AppColors.primaryDark,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.movie_filter_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back 👋',
                          style: TextStyle(
                            color: AppColors.textGrey,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Find your next movie',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.border,
                      ),
                    ),
                    child: const Icon(
                      Icons.notifications_none_rounded,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 25),
          ),

          // ---------------------------------------------------------
          // FEATURED MOVIES
          // ---------------------------------------------------------
          SliverToBoxAdapter(
            child: SizedBox(
              height: 305,
              child: trending.isEmpty
                  ? _emptyFeatured()
                  : PageView.builder(
                controller: _featuredController,
                itemCount: trending.length,
                padEnds: false,
                itemBuilder: (context, index) {
                  return _featuredMovieCard(
                    trending[index],
                  );
                },
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 28),
          ),

          // ---------------------------------------------------------
          // TRENDING NOW
          // ---------------------------------------------------------
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SectionTitle(
                title: 'Trending Now',
                actionText: 'See all',
                onAction: () {
                  setState(() {
                    currentIndex = 1;
                  });
                },
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 15),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 255,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: trending.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 14);
                },
                itemBuilder: (context, index) {
                  return MovieCard(
                    movie: trending[index],
                    onFavoriteChanged: refresh,
                  );
                },
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 28),
          ),

          // ---------------------------------------------------------
          // GENRES
          // ---------------------------------------------------------
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SectionTitle(
                title: 'Genres',
                actionText: 'Explore',
                onAction: () {},
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 14),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 42,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: AppConstants.genres.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 9);
                },
                itemBuilder: (context, index) {
                  final genre = AppConstants.genres[index];

                  return GenreChip(
                    label: genre,
                    selected: selectedGenre == genre,
                    onTap: () {
                      setState(() {
                        selectedGenre = genre;
                      });
                    },
                  );
                },
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 28),
          ),

          // ---------------------------------------------------------
          // ALL MOVIES / FILTERED MOVIES
          // ---------------------------------------------------------
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: SectionTitle(
                title: selectedGenre == 'All'
                    ? 'All Movies'
                    : '$selectedGenre Movies',
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 15),
          ),

          if (filteredMovies.isEmpty)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Text(
                    'No movies found',
                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    return MovieCard(
                      movie: filteredMovies[index],
                      width: double.infinity,
                      onFavoriteChanged: refresh,
                    );
                  },
                  childCount: filteredMovies.length,
                ),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 20,
                  childAspectRatio: .58,
                ),
              ),
            ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 30),
          ),

          // ---------------------------------------------------------
          // TOP RATED
          // ---------------------------------------------------------
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SectionTitle(
                title: 'Top Rated',
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 15),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 255,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: topRated.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 14);
                },
                itemBuilder: (context, index) {
                  return MovieCard(
                    movie: topRated[index],
                    onFavoriteChanged: refresh,
                  );
                },
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 35),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------
  // FEATURED MOVIE CARD
  // ---------------------------------------------------------------
  Widget _featuredMovieCard(Movie movie) {
    return GestureDetector(
      onTap: () => openMovie(movie),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: AppColors.card,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Movie backdrop
            CachedNetworkImage(
              imageUrl: movie.backdropUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return _imagePlaceholder();
              },
              errorWidget: (context, url, error) {
                return _imagePlaceholder();
              },
            ),

            // Dark gradient over image
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: .15),
                    Colors.black.withValues(alpha: .95),
                  ],
                ),
              ),
            ),

            // Movie information
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.gold,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: Colors.black,
                              size: 14,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              movie.rating.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        movie.genre,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 9),

                  Text(
                    movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    '${movie.year} • ${movie.duration}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // Favorite button
            Positioned(
              right: 15,
              top: 15,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    movie.isFavorite = !movie.isFavorite;
                  });
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: .55),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    movie.isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: movie.isFavorite
                        ? Colors.redAccent
                        : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------
  // IMAGE PLACEHOLDER
  // ---------------------------------------------------------------
  Widget _imagePlaceholder() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.surface,
            AppColors.card,
            AppColors.primaryDark,
          ],
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.movie_rounded,
          size: 60,
          color: AppColors.textGrey,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------
  // EMPTY FEATURED STATE
  // ---------------------------------------------------------------
  Widget _emptyFeatured() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(25),
      ),
      child: const Center(
        child: Text(
          'No featured movies',
          style: TextStyle(
            color: AppColors.textGrey,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}