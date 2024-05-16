import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/provider/tvseries/watch_list_tvseries_notifier.dart';
import 'package:ditonton/presentation/provider/movie/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tvseries_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  const WatchlistPage({super.key});

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistPage>
    with RouteAware, TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future.microtask(() =>
        Provider.of<WatchlistMovieNotifier>(context, listen: false)
            .fetchWatchlistMovies());
    Future.microtask(() =>
        Provider.of<WatchListTVSeriesNotifier>(context, listen: false)
            .fetchWatchlistTv());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchListTVSeriesNotifier>(context, listen: false)
        .fetchWatchlistTv();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Movies'),
            Tab(text: 'TV Series'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<WatchlistMovieNotifier>(
              builder: (context, data, child) {
                if (data.watchlistState == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data.watchlistState == RequestState.Loaded) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final movie = data.watchlistMovies[index];
                      return MovieCard(movie);
                    },
                    itemCount: data.watchlistMovies.length,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<WatchListTVSeriesNotifier>(
              builder: (context, data, child) {
                if (data.watchlistState == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data.watchlistState == RequestState.Loaded) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final tv = data.watchlistTv[index];
                      return TVSeriesCard(tv);
                    },
                    itemCount: data.watchlistTv.length,
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
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
