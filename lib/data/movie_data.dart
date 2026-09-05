import '../models/movie_model.dart';

class MovieData {
  static final List<Movie> movies = [
    Movie(
      id: 1,
      title: 'Interstellar',
      posterUrl:
      'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
      backdropUrl:
      'https://image.tmdb.org/t/p/w1280/xJHokMbljvjADYdit5fK5zVQp9J.jpg',
      description:
      'A team of explorers travel through a wormhole in space in an attempt to ensure humanity’s survival.',
      genre: 'Sci-Fi',
      year: '2014',
      duration: '2h 49m',
      rating: 8.7,
      director: 'Christopher Nolan',
      cast: [
        'Matthew McConaughey',
        'Anne Hathaway',
        'Jessica Chastain',
      ],
    ),

    Movie(
      id: 2,
      title: 'Inception',
      posterUrl:
      'https://image.tmdb.org/t/p/w500/oYuLEt3zVCKq57qu2F8dT7NIa6f.jpg',
      backdropUrl:
      'https://image.tmdb.org/t/p/w1280/s3TBrRGB1iav7gFOCNx3H31MoES.jpg',
      description:
      'A skilled thief who steals secrets through dream-sharing technology is given a chance to erase his past.',
      genre: 'Thriller',
      year: '2010',
      duration: '2h 28m',
      rating: 8.8,
      director: 'Christopher Nolan',
      cast: [
        'Leonardo DiCaprio',
        'Joseph Gordon-Levitt',
        'Elliot Page',
      ],
    ),

    Movie(
      id: 3,
      title: 'The Dark Knight',
      posterUrl:
      'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
      backdropUrl:
      'https://image.tmdb.org/t/p/w1280/hqkIcbrOHL86UncnHIsHVcVxueM.jpg',
      description:
      'Batman faces a criminal mastermind who plunges Gotham into chaos and challenges the city’s greatest hero.',
      genre: 'Action',
      year: '2008',
      duration: '2h 32m',
      rating: 9.0,
      director: 'Christopher Nolan',
      cast: [
        'Christian Bale',
        'Heath Ledger',
        'Aaron Eckhart',
      ],
    ),

    Movie(
      id: 4,
      title: 'Spider-Man: Across the Spider-Verse',
      posterUrl:
      'https://image.tmdb.org/t/p/w500/8Vt6mWEReuy4Of61Lnj5Xj704m8.jpg',
      backdropUrl:
      'https://image.tmdb.org/t/p/w1280/6ELJEzQJ3Y45HczvreCzB1qk4tB.jpg',
      description:
      'Miles Morales travels across the multiverse and meets a team of Spider-People charged with protecting reality.',
      genre: 'Animation',
      year: '2023',
      duration: '2h 20m',
      rating: 8.6,
      director: 'Joaquim Dos Santos',
      cast: [
        'Shameik Moore',
        'Hailee Steinfeld',
        'Oscar Isaac',
      ],
    ),

    Movie(
      id: 5,
      title: 'The Matrix',
      posterUrl:
      'https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg',
      backdropUrl:
      'https://image.tmdb.org/t/p/w1280/icmmSD4vTTDKOq2vvdulafOGw93.jpg',
      description:
      'A computer hacker discovers that reality as he knows it is actually a simulated world controlled by machines.',
      genre: 'Sci-Fi',
      year: '1999',
      duration: '2h 16m',
      rating: 8.7,
      director: 'The Wachowskis',
      cast: [
        'Keanu Reeves',
        'Laurence Fishburne',
        'Carrie-Anne Moss',
      ],
    ),

    Movie(
      id: 6,
      title: 'La La Land',
      posterUrl:
      'https://image.tmdb.org/t/p/w500/uDO8zWDhfWwoFdKS4fzkUJt0Rf0.jpg',
      backdropUrl:
      'https://image.tmdb.org/t/p/w1280/n6bUvigpRFqSwmPp1m2YADdbRBc.jpg',
      description:
      'A jazz musician and an aspiring actress fall in love while pursuing their dreams in Los Angeles.',
      genre: 'Drama',
      year: '2016',
      duration: '2h 8m',
      rating: 8.0,
      director: 'Damien Chazelle',
      cast: [
        'Ryan Gosling',
        'Emma Stone',
        'John Legend',
      ],
    ),

    Movie(
      id: 7,
      title: 'The Hangover',
      posterUrl:
      'https://image.tmdb.org/t/p/w500/AqgMH8mBGEYJd0K4r0R4eK3b9vY.jpg',
      backdropUrl:
      'https://image.tmdb.org/t/p/w1280/3RbzM8B7N7B8D8pY9K6Q5J4L3M2.jpg',
      description:
      'Three friends wake up after a wild night in Las Vegas and try to piece together what happened.',
      genre: 'Comedy',
      year: '2009',
      duration: '1h 40m',
      rating: 7.7,
      director: 'Todd Phillips',
      cast: [
        'Bradley Cooper',
        'Ed Helms',
        'Zach Galifianakis',
      ],
    ),

    Movie(
      id: 8,
      title: 'Mad Max: Fury Road',
      posterUrl:
      'https://image.tmdb.org/t/p/w500/hA2ple9q4qnwxp3hKVNhroipsir.jpg',
      backdropUrl:
      'https://image.tmdb.org/t/p/w1280/8yAC5Qr5s4u2v7b6n5m4l3k2j1h.jpg',
      description:
      'In a ruined wasteland, Max joins Furiosa and a group of rebels fleeing from a tyrant.',
      genre: 'Action',
      year: '2015',
      duration: '2h',
      rating: 8.1,
      director: 'George Miller',
      cast: [
        'Tom Hardy',
        'Charlize Theron',
        'Nicholas Hoult',
      ],
    ),

    Movie(
      id: 9,
      title: 'The Prestige',
      posterUrl:
      'https://image.tmdb.org/t/p/w500/5MXyQfz8xUP3dIFh9r2f0qT3aJp.jpg',
      backdropUrl:
      'https://image.tmdb.org/t/p/w1280/Ag2B2E9O6hJ4c7X8r5K3m2L1N0.jpg',
      description:
      'Two rival magicians engage in a dangerous battle of obsession, sacrifice and deception.',
      genre: 'Drama',
      year: '2006',
      duration: '2h 10m',
      rating: 8.5,
      director: 'Christopher Nolan',
      cast: [
        'Christian Bale',
        'Hugh Jackman',
        'Scarlett Johansson',
      ],
    ),

    Movie(
      id: 10,
      title: 'Knives Out',
      posterUrl:
      'https://image.tmdb.org/t/p/w500/p9z1xM9R6J7K8L9M0N1B2V3C4X5.jpg',
      backdropUrl:
      'https://image.tmdb.org/t/p/w1280/6Wdl9N6d5J7K8L9M0N1B2V3C4X5.jpg',
      description:
      'A detective investigates the mysterious death of a wealthy crime novelist surrounded by his family.',
      genre: 'Thriller',
      year: '2019',
      duration: '2h 10m',
      rating: 8.0,
      director: 'Rian Johnson',
      cast: [
        'Daniel Craig',
        'Ana de Armas',
        'Chris Evans',
      ],
    ),
  ];
}