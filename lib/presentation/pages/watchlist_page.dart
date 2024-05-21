import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries/watchlist/tvseries_watchlist_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tvseries_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    BlocProvider.of<WatchlistMovieBloc>(context)
        .add(const LoadWatchListMovie());
    BlocProvider.of<TVSeriesWatchlistBloc>(context)
        .add(const LoadWatchListTVSeries());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    BlocProvider.of<WatchlistMovieBloc>(context)
        .add(const LoadWatchListMovie());
    BlocProvider.of<TVSeriesWatchlistBloc>(context)
        .add(const LoadWatchListTVSeries());
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
            child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
              builder: (context, state) {
                if (state is WatchListMovieLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is WatchListMovieSuccess) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final movie = state.results[index];
                      return MovieCard(movie);
                    },
                    itemCount: state.results.length,
                  );
                } else if (state is WatchListMovieError) {
                  return Center(
                    key: const Key('error_message'),
                    child: Text(state.message),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<TVSeriesWatchlistBloc, TVSeriesWatchlistState>(
              builder: (context, state) {
                if (state is TVSeriesWatchListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TVSeriesWatchListSuccess) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final tv = state.results[index];
                      return TVSeriesCard(tv);
                    },
                    itemCount: state.results.length,
                  );
                } else if (state is TVSeriesWatchListError) {
                  return Center(
                    key: const Key('error_message'),
                    child: Text(state.message),
                  );
                }
                return const SizedBox();
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
