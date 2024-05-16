import 'package:ditonton/presentation/provider/tvseries/top_rated_tvseries_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/state_enum.dart';
import '../../widgets/tvseries_card_list.dart';

class TopRatedTSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tvseries';
  const TopRatedTSeriesPage({super.key});

  @override
  State<TopRatedTSeriesPage> createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TopRatedTVSeriesNotifier>(context, listen: false)
            .fetchTopRatedTVSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopRatedTVSeriesNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.tvSeries[index];
                  return TVSeriesCard(tv);
                },
                itemCount: data.tvSeries.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
