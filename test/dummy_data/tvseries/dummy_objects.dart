import 'package:ditonton/data/models/tvseries/tvseries_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries_detail.dart';

const testTv = TVSeries(
  backdropPath: '/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg',
  genreIds: [18, 80],
  id: 278,
  originalName: 'The Shawshank Redemption',
  overview:
      'Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.',
  popularity: 161.431,
  posterPath: '/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg',
  firstAirDate: '1994-09-23',
  name: 'The Shawshank Redemption',
  voteAverage: 8.705,
  voteCount: 26158,
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
