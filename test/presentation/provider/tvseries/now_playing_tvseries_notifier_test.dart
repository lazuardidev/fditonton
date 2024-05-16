import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_now_playing_tvseries.dart';
import 'package:ditonton/presentation/provider/tvseries/now_playing_tvseries_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'tvseries_list_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingTVSeries])
void main() {
  late MockGetNowPlayingTVSeries mockGetNowPlayingTVSeries;
  late NowPlayingTVSeriesNotifier nowPlayingTVSeriesNotifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTVSeries = MockGetNowPlayingTVSeries();
    nowPlayingTVSeriesNotifier = NowPlayingTVSeriesNotifier(mockGetNowPlayingTVSeries)
      ..addListener(() {
        listenerCallCount++;
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

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetNowPlayingTVSeries.execute()).thenAnswer((_) async => Right(tTvList));
    // act
    nowPlayingTVSeriesNotifier.fetchNowPlayingTVSeries();
    // assert
    expect(nowPlayingTVSeriesNotifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv data when data is gotten successfully', () async {
    // arrange
    when(mockGetNowPlayingTVSeries.execute()).thenAnswer((_) async => Right(tTvList));
    // act
    await nowPlayingTVSeriesNotifier.fetchNowPlayingTVSeries();
    // assert
    expect(nowPlayingTVSeriesNotifier.state, RequestState.Loaded);
    expect(nowPlayingTVSeriesNotifier.tvSeries, tTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetNowPlayingTVSeries.execute())
        .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
    // act
    await nowPlayingTVSeriesNotifier.fetchNowPlayingTVSeries();
    // assert
    expect(nowPlayingTVSeriesNotifier.state, RequestState.Error);
    expect(nowPlayingTVSeriesNotifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
