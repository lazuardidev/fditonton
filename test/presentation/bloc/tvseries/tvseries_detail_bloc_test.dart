import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries_detail.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tvseries_detail.dart';
import 'package:ditonton/presentation/bloc/tvseries/tvseries_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';

import 'tvseries_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTVSeriesDetail])
void main() {
  late TVSeriesDetailBloc tvDetailBloc;
  late MockGetTVSeriesDetail mockGetTVSeriesDetail;

  setUp(() {
    mockGetTVSeriesDetail = MockGetTVSeriesDetail();
    tvDetailBloc = TVSeriesDetailBloc(mockGetTVSeriesDetail);
  });

  test('initial should be empty', () {
    expect(tvDetailBloc.state, TVSeriesDetailEmpty());
  });

  const tId = 1;

  const List<Season> seasons = [
    Season(
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

  const tvDetail = TVSeriesDetail(
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    lastAirDate: 'lastAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
    episodeRunTime: [1],
    homepage: 'homePage',
    inProduction: true,
    languages: ['en'],
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originCountry: ['USA'],
    originalLanguage: 'en',
    popularity: 1,
    seasons: seasons,
    status: 'status',
    tagline: 'tagLine',
    type: 'type',
  );

  blocTest<TVSeriesDetailBloc, TVSeriesDetailState>(
      'emits [Loading, Success] when data is gotten successfully',
      build: () {
        when(mockGetTVSeriesDetail.execute(tId))
            .thenAnswer((_) async => right(tvDetail));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const LoadTVSeriesDetail(tId)),
      expect: () => [
            TVSeriesDetailLoading(),
            const TVSeriesDetailSuccess(result: tvDetail)
          ],
      verify: (bloc) {
        verify(mockGetTVSeriesDetail.execute(tId));
      });

  blocTest<TVSeriesDetailBloc, TVSeriesDetailState>(
      'emits [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(mockGetTVSeriesDetail.execute(tId)).thenAnswer(
            (_) async => left(const ServerFailure('Server failure')));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const LoadTVSeriesDetail(tId)),
      expect: () => [
            TVSeriesDetailLoading(),
            const TVSeriesDetailError('Server failure')
          ],
      verify: (bloc) {
        verify(mockGetTVSeriesDetail.execute(tId));
      });
}
