import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/presentation/pages/tvseries/popular_tvseries_page.dart';
import 'package:ditonton/presentation/provider/tvseries/popular_tvseries_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'popular_tvseries_page_test.mocks.dart';

@GenerateMocks([PopularTVSeriesNotifier])
void main() {
  late MockPopularTVSeriesNotifier mockPopularTVSeriesNotifier;

  setUp(() {
    mockPopularTVSeriesNotifier = MockPopularTVSeriesNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<PopularTVSeriesNotifier>.value(
      value: mockPopularTVSeriesNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockPopularTVSeriesNotifier.state).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const PopularTVSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockPopularTVSeriesNotifier.state).thenReturn(RequestState.Loaded);
    when(mockPopularTVSeriesNotifier.tvSeries).thenReturn(<TVSeries>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const PopularTVSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockPopularTVSeriesNotifier.state).thenReturn(RequestState.Error);
    when(mockPopularTVSeriesNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const PopularTVSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
