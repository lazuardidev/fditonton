import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/presentation/pages/tvseries/tvseries_detail_page.dart';
import 'package:ditonton/presentation/provider/tvseries/tvseries_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import '../../../dummy_data/tvseries/dummy_objects.dart';
import 'tvseries_detail_page_test.mocks.dart';

@GenerateMocks([TVSeriesDetailNotifier])
void main() {
  late MockTVSeriesDetailNotifier mockTVSeriesDetailNotifier;

  setUp(() {
    mockTVSeriesDetailNotifier = MockTVSeriesDetailNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TVSeriesDetailNotifier>.value(
      value: mockTVSeriesDetailNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(mockTVSeriesDetailNotifier.tvState).thenReturn(RequestState.Loaded);
    when(mockTVSeriesDetailNotifier.tv).thenReturn(testTvDetail);
    when(mockTVSeriesDetailNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockTVSeriesDetailNotifier.tvRecommendations).thenReturn(<TVSeries>[]);
    when(mockTVSeriesDetailNotifier.isAddedToWatchlist).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester
        .pumpWidget(makeTestableWidget(const TVSeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(mockTVSeriesDetailNotifier.tvState).thenReturn(RequestState.Loaded);
    when(mockTVSeriesDetailNotifier.tv).thenReturn(testTvDetail);
    when(mockTVSeriesDetailNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockTVSeriesDetailNotifier.tvRecommendations).thenReturn(<TVSeries>[]);
    when(mockTVSeriesDetailNotifier.isAddedToWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester
        .pumpWidget(makeTestableWidget(const TVSeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockTVSeriesDetailNotifier.tvState).thenReturn(RequestState.Loaded);
    when(mockTVSeriesDetailNotifier.tv).thenReturn(testTvDetail);
    when(mockTVSeriesDetailNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockTVSeriesDetailNotifier.tvRecommendations).thenReturn(<TVSeries>[]);
    when(mockTVSeriesDetailNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockTVSeriesDetailNotifier.watchlistMessage).thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester
        .pumpWidget(makeTestableWidget(const TVSeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockTVSeriesDetailNotifier.tvState).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester
        .pumpWidget(makeTestableWidget(const TVSeriesDetailPage(id: 1)));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockTVSeriesDetailNotifier.tvState).thenReturn(RequestState.Loaded);
    when(mockTVSeriesDetailNotifier.tv).thenReturn(testTvDetail);
    when(mockTVSeriesDetailNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockTVSeriesDetailNotifier.tvRecommendations).thenReturn(<TVSeries>[]);
    when(mockTVSeriesDetailNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockTVSeriesDetailNotifier.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(ElevatedButton);

    await tester
        .pumpWidget(makeTestableWidget(const TVSeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
