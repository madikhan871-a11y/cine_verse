import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/movie_model.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailScreen({
    super.key,
    required this.movie,
  });

  @override
  State<MovieDetailScreen> createState() =>
      _MovieDetailScreenState();
}

class _MovieDetailScreenState
    extends State<MovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 360,
            pinned: true,
            backgroundColor: AppColors.background,
            leading: Padding(
              padding: const EdgeInsets.all(7),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.5),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(7),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.5),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        movie.isFavorite =
                        !movie.isFavorite;
                      });
                    },
                    icon: Icon(
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
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
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
                          size: 70,
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
                          Colors.black.withOpacity(.15),
                          Colors.transparent,
                          AppColors.background,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                5,
                20,
                35,
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Row(
                    children: [
                      _infoBadge(
                        Icons.star_rounded,
                        movie.rating.toString(),
                        AppColors.gold,
                      ),
                      const SizedBox(width: 8),
                      _infoBadge(
                        Icons.calendar_today_rounded,
                        movie.year,
                        AppColors.secondary,
                      ),
                      const SizedBox(width: 8),
                      _infoBadge(
                        Icons.access_time_rounded,
                        movie.duration,
                        AppColors.secondary,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Wrap(
                    spacing: 8,
                    children: [
                      Container(
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary
                              .withOpacity(.15),
                          borderRadius:
                          BorderRadius.circular(20),
                        ),
                        child: Text(
                          movie.genre,
                          style: const TextStyle(
                            color: AppColors.secondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'Overview',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    movie.description,
                    style: const TextStyle(
                      color: AppColors.textGrey,
                      height: 1.7,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'Movie Info',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 15),

                  _infoRow(
                    'Director',
                    movie.director,
                  ),

                  const SizedBox(height: 12),

                  _infoRow(
                    'Genre',
                    movie.genre,
                  ),

                  const SizedBox(height: 12),

                  _infoRow(
                    'Release Year',
                    movie.year,
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'Cast',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 15),

                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: movie.cast.length,
                      separatorBuilder: (_, __) =>
                      const SizedBox(width: 8),
                      itemBuilder: (_, index) {
                        return Container(
                          padding:
                          const EdgeInsets.symmetric(
                            horizontal: 13,
                            vertical: 9,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius:
                            BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.border,
                            ),
                          ),
                          child: Text(
                            movie.cast[index],
                            style: const TextStyle(
                              color: AppColors.textGrey,
                              fontSize: 11,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Trailer feature is demo-only.',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.play_arrow_rounded,
                      ),
                      label: const Text(
                        'Watch Trailer',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoBadge(
      IconData icon,
      String text,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 15,
            color: color,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(
      String title,
      String value,
      ) {
    return Row(
      children: [
        SizedBox(
          width: 105,
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.textGrey,
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}