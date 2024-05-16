import 'package:ditonton/data/models/tvseries/tvseries_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries_detail.dart';

const testTv = TVSeries(
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalName: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  firstAirDate: '2002-05-01',
  name: 'Spider-Man',
  voteAverage: 7.2,
  voteCount: 13507,
  originCountry: ['en'],
  originalLanguage: 'en',
);

final testTvList = [testTv];

final testTvDetail = TVSeriesDetail(
  backdropPath: 'backdropPath',
  genres: const [Genre(id: 1, name: 'Action')],
  id: 1,
  originalName: 'originalName',
  overview: 'overview',
  posterPath: 'posterPath',
  firstAirDate: 'firstAirDate',
  lastAirDate: 'lastAirDate',
  name: 'name',
  voteAverage: 1,
  voteCount: 1,
  episodeRunTime: const [1],
  homepage: 'homePage',
  inProduction: true,
  languages: const ['en'],
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  originCountry: const ['USA'],
  originalLanguage: 'en',
  popularity: 1,
  seasons: seasons,
  status: 'status',
  tagline: 'tagLine',
  type: 'type',
);

final List<Season> seasons = [
  const Season(
    airDate: 'airDate',
    episodeCount: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
    voteAverage: 1,
  )
];

const testWatchlistTv = TVSeries.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testTvTable = TVSeriesTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
