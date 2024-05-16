import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tvseries_detail.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tvseries_recommendation.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_tvseries_status.dart';
import 'package:ditonton/domain/usecases/tvseries/remove_watchlist_tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/save_watchlist_tvseries.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tvseries/tvseries_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/tvseries/dummy_objects.dart';
import 'tvseries_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTVSeriesDetail,
  GetTVSeriesRecommendation,
  GetWatchListTVSeriesStatus,
  SaveWatchListTVSeries,
  RemoveWatchListTVSeries,
])
void main() {
  late TVSeriesDetailNotifier tvSeriesDetailNotifier;
  late MockGetTVSeriesDetail mockGetTVSeriesDetail;
  late MockGetTVSeriesRecommendation mockGetTVSeriesRecommendation;
  late MockGetWatchListTVSeriesStatus mockGetWatchListTVSeriesStatus;
  late MockSaveWatchListTVSeries mockSaveWatchListTVSeries;
  late MockRemoveWatchListTVSeries mockRemoveWatchListTVSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTVSeriesDetail = MockGetTVSeriesDetail();
    mockGetTVSeriesRecommendation = MockGetTVSeriesRecommendation();
    mockGetWatchListTVSeriesStatus = MockGetWatchListTVSeriesStatus();
    mockSaveWatchListTVSeries = MockSaveWatchListTVSeries();
    mockRemoveWatchListTVSeries = MockRemoveWatchListTVSeries();
    tvSeriesDetailNotifier = TVSeriesDetailNotifier(
      getTVSeriesDetail: mockGetTVSeriesDetail,
      getTVSeriesRecommendations: mockGetTVSeriesRecommendation,
      getWatchListTvStatus: mockGetWatchListTVSeriesStatus,
      saveWatchListTv: mockSaveWatchListTVSeries,
      removeWatchListTv: mockRemoveWatchListTVSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  const tId = 1;

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

  void arrangeUsecase() {
    when(mockGetTVSeriesDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvDetail));
    when(mockGetTVSeriesRecommendation.execute(tId))
        .thenAnswer((_) async => Right(tTvList));
  }

  group('Get TVSeries Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      arrangeUsecase();
      // act
      await tvSeriesDetailNotifier.fetchTvDetail(tId);
      // assert
      verify(mockGetTVSeriesDetail.execute(tId));
      verify(mockGetTVSeriesRecommendation.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      arrangeUsecase();
      // act
      tvSeriesDetailNotifier.fetchTvDetail(tId);
      // assert
      expect(tvSeriesDetailNotifier.tvState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv when data is gotten successfully', () async {
      // arrange
      arrangeUsecase();
      // act
      await tvSeriesDetailNotifier.fetchTvDetail(tId);
      // assert
      expect(tvSeriesDetailNotifier.tvState, RequestState.Loaded);
      expect(tvSeriesDetailNotifier.tv, testTvDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation tv when data is gotten successfully',
        () async {
      // arrange
      arrangeUsecase();
      // act
      await tvSeriesDetailNotifier.fetchTvDetail(tId);
      // assert
      expect(tvSeriesDetailNotifier.tvState, RequestState.Loaded);
      expect(tvSeriesDetailNotifier.tvRecommendations, tTvList);
    });
  });

  group('Get TVSeries Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      arrangeUsecase();
      // act
      await tvSeriesDetailNotifier.fetchTvDetail(tId);
      // assert
      verify(mockGetTVSeriesRecommendation.execute(tId));
      expect(tvSeriesDetailNotifier.tvRecommendations, tTvList);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      arrangeUsecase();
      // act
      await tvSeriesDetailNotifier.fetchTvDetail(tId);
      // assert
      expect(tvSeriesDetailNotifier.recommendationState, RequestState.Loaded);
      expect(tvSeriesDetailNotifier.tvRecommendations, tTvList);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTVSeriesDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvDetail));
      when(mockGetTVSeriesRecommendation.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Failed')));
      // act
      await tvSeriesDetailNotifier.fetchTvDetail(tId);
      // assert
      expect(tvSeriesDetailNotifier.recommendationState, RequestState.Error);
      expect(tvSeriesDetailNotifier.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchListTVSeriesStatus.execute(1)).thenAnswer((_) async => true);
      // act
      await tvSeriesDetailNotifier.loadWatchlistStatus(1);
      // assert
      expect(tvSeriesDetailNotifier.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchListTVSeries.execute(testTvDetail))
          .thenAnswer((_) async => const Right('Success'));
      when(mockGetWatchListTVSeriesStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await tvSeriesDetailNotifier.addWatchlist(testTvDetail);
      // assert
      verify(mockSaveWatchListTVSeries.execute(testTvDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchListTVSeries.execute(testTvDetail))
          .thenAnswer((_) async => const Right('Removed'));
      when(mockGetWatchListTVSeriesStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await tvSeriesDetailNotifier.removeFromWatchlist(testTvDetail);
      // assert
      verify(mockRemoveWatchListTVSeries.execute(testTvDetail));
    });

    test('should update watchlist status failed to remove', () async {
      // arrange
      when(mockRemoveWatchListTVSeries.execute(testTvDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
      when(mockGetWatchListTVSeriesStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await tvSeriesDetailNotifier.removeFromWatchlist(testTvDetail);
      // assert
      expect(tvSeriesDetailNotifier.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchListTVSeries.execute(testTvDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      when(mockGetWatchListTVSeriesStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await tvSeriesDetailNotifier.addWatchlist(testTvDetail);
      // assert
      verify(mockGetWatchListTVSeriesStatus.execute(testTvDetail.id));
      expect(tvSeriesDetailNotifier.isAddedToWatchlist, true);
      expect(tvSeriesDetailNotifier.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchListTVSeries.execute(testTvDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
      when(mockGetWatchListTVSeriesStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await tvSeriesDetailNotifier.addWatchlist(testTvDetail);
      // assert
      expect(tvSeriesDetailNotifier.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTVSeriesDetail.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      when(mockGetTVSeriesRecommendation.execute(tId))
          .thenAnswer((_) async => Right(tTvList));
      // act
      await tvSeriesDetailNotifier.fetchTvDetail(tId);
      // assert
      expect(tvSeriesDetailNotifier.tvState, RequestState.Error);
      expect(tvSeriesDetailNotifier.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
