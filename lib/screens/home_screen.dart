import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import '../data/movie_data.dart';
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

  final PageController _featuredController = PageController(
    viewportFraction: .9,
  );

  @override
  void dispose() {
    _featuredController.dispose();
    super.dispose();
  }

  void refresh() {
    setState(() {});
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
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
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

          SliverToBoxAdapter(
            child: SizedBox(
              height: 305,
              child: PageView.builder(
                controller: _featuredController,
                itemCount: trending.length,
                itemBuilder: (context, index) {
                  return _featuredMovieCard(trending[index]);
                },
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 28),
          ),

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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemCount: trending.length,
                separatorBuilder: (_, __) =>
                const SizedBox(width: 14),
                itemBuilder: (_, index) {
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemCount: AppConstants.genres.length,
                separatorBuilder: (_, __) =>
                const SizedBox(width: 9),
                itemBuilder: (_, index) {
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemCount: topRated.length,
                separatorBuilder: (_, __) =>
                const SizedBox(width: 14),
                itemBuilder: (_, index) {
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

  Widget _featuredMovieCard(Movie movie) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MovieDetailScreen(movie: movie),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: AppColors.card,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: movie.backdropUrl,
              fit: BoxFit.cover,
              errorWidget: (_, __, ___) {
                return Container(
                  color: AppColors.card,
                  child: const Icon(
                    Icons.movie_rounded,
                    size: 60,
                    color: AppColors.textGrey,
                  ),
                );
              },
            ),

            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(.15),
                    Colors.black.withOpacity(.95),
                  ],
                ),
              ),
            ),

            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
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
                          borderRadius:
                          BorderRadius.circular(7),
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

            Positioned(
              right: 15,
              top: 15,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    movie.isFavorite =
                    !movie.isFavorite;
                  });
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.55),
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
}