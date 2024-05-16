import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/presentation/pages/tvseries/top_rated_tvseries_page.dart';
import 'package:ditonton/presentation/provider/tvseries/top_rated_tvseries_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'top_rated_tvseries_page_test.mocks.dart';

@GenerateMocks([TopRatedTVSeriesNotifier])
void main() {
  late MockTopRatedTVSeriesNotifier mockTopRatedTVSeriesNotifier;

  setUp(() {
    mockTopRatedTVSeriesNotifier = MockTopRatedTVSeriesNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TopRatedTVSeriesNotifier>.value(
      value: mockTopRatedTVSeriesNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockTopRatedTVSeriesNotifier.state).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const TopRatedTSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockTopRatedTVSeriesNotifier.state).thenReturn(RequestState.Loaded);
    when(mockTopRatedTVSeriesNotifier.tvSeries).thenReturn(<TVSeries>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const TopRatedTSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockTopRatedTVSeriesNotifier.state).thenReturn(RequestState.Error);
    when(mockTopRatedTVSeriesNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const TopRatedTSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
