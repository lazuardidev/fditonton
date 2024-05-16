import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/presentation/pages/tvseries/now_playing_tvseries_page.dart';
import 'package:ditonton/presentation/provider/tvseries/now_playing_tvseries_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'now_playing_tvseries_page_test.mocks.dart';

@GenerateMocks([NowPlayingTVSeriesNotifier])
void main() {
  late MockNowPlayingTVSeriesNotifier mockNowPlayingTVSeriesNotifier;

  setUp(() {
    mockNowPlayingTVSeriesNotifier = MockNowPlayingTVSeriesNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<NowPlayingTVSeriesNotifier>.value(
      value: mockNowPlayingTVSeriesNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNowPlayingTVSeriesNotifier.state).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const NowPlayingTVSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNowPlayingTVSeriesNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNowPlayingTVSeriesNotifier.tvSeries).thenReturn(<TVSeries>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const NowPlayingTVSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNowPlayingTVSeriesNotifier.state).thenReturn(RequestState.Error);
    when(mockNowPlayingTVSeriesNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const NowPlayingTVSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
