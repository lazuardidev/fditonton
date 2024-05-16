import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tvseries/get_now_playing_tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_popular_tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_top_rated_tvseries.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tvseries/tvseries_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'tvseries_list_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingTVSeries, GetPopularTVSeries, GetTopRatedTVSeries])
void main() {
  late TVSeriesListNotifier tvSeriesListNotifier;
  late MockGetNowPlayingTVSeries mockGetNowPlayingTVSeries;
  late MockGetPopularTVSeries mockGetPopularTVSeries;
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTVSeries = MockGetNowPlayingTVSeries();
    mockGetPopularTVSeries = MockGetPopularTVSeries();
    mockGetTopRatedTVSeries = MockGetTopRatedTVSeries();
    tvSeriesListNotifier = TVSeriesListNotifier(
      getNowPlayingTVSeries: mockGetNowPlayingTVSeries,
      getPopularTVSeries: mockGetPopularTVSeries,
      getTopRatedTVSeries: mockGetTopRatedTVSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  const tTv = TVSeries(
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

  final tTvList = <TVSeries>[tTv];

  group('now playing tv', () {
    test('initialState should be Empty', () {
      expect(tvSeriesListNotifier.nowPlayingState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetNowPlayingTVSeries.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      tvSeriesListNotifier.fetchNowPlayingTV();
      // assert
      verify(mockGetNowPlayingTVSeries.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetNowPlayingTVSeries.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      tvSeriesListNotifier.fetchNowPlayingTV();
      // assert
      expect(tvSeriesListNotifier.nowPlayingState, RequestState.Loading);
    });

    test('should change tv when data is gotten successfully', () async {
      // arrange
      when(mockGetNowPlayingTVSeries.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      await tvSeriesListNotifier.fetchNowPlayingTV();
      // assert
      expect(tvSeriesListNotifier.nowPlayingState, RequestState.Loaded);
      expect(tvSeriesListNotifier.nowPlayingTv, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetNowPlayingTVSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await tvSeriesListNotifier.fetchNowPlayingTV();
      // assert
      expect(tvSeriesListNotifier.nowPlayingState, RequestState.Error);
      expect(tvSeriesListNotifier.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTVSeries.execute()).thenAnswer((_) async => Right(tTvList));
      // act
      tvSeriesListNotifier.fetchPopularTV();
      // assert
      expect(tvSeriesListNotifier.popularState, RequestState.Loading);
      // verify(tvSeriesListNotifier.setState(RequestState.Loading));
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularTVSeries.execute()).thenAnswer((_) async => Right(tTvList));
      // act
      await tvSeriesListNotifier.fetchPopularTV();
      // assert
      expect(tvSeriesListNotifier.popularState, RequestState.Loaded);
      expect(tvSeriesListNotifier.popularTv, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTVSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await tvSeriesListNotifier.fetchPopularTV();
      // assert
      expect(tvSeriesListNotifier.popularState, RequestState.Error);
      expect(tvSeriesListNotifier.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTVSeries.execute()).thenAnswer((_) async => Right(tTvList));
      // act
      tvSeriesListNotifier.fetchTopRatedTV();
      // assert
      expect(tvSeriesListNotifier.topRatedState, RequestState.Loading);
    });

    test('should change tv data when data is gotten successfully', () async {
      // arrange
      when(mockGetTopRatedTVSeries.execute()).thenAnswer((_) async => Right(tTvList));
      // act
      await tvSeriesListNotifier.fetchTopRatedTV();
      // assert
      expect(tvSeriesListNotifier.topRatedState, RequestState.Loaded);
      expect(tvSeriesListNotifier.topRatedTV, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await tvSeriesListNotifier.fetchTopRatedTV();
      // assert
      expect(tvSeriesListNotifier.topRatedState, RequestState.Error);
      expect(tvSeriesListNotifier.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
