import 'package:ditonton/presentation/bloc/tvseries/nowplaying/now_playing_tvseries_bloc.dart';
import 'package:ditonton/presentation/widgets/tvseries_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NowPlayingTVSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-tvseries';
  const NowPlayingTVSeriesPage({super.key});

  @override
  State<NowPlayingTVSeriesPage> createState() => _NowPlayingTVSeriesPageState();
}

class _NowPlayingTVSeriesPageState extends State<NowPlayingTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NowPlayingTVSeriesBloc>(context)
        .add(LoadNowPlayingTVSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingTVSeriesBloc, NowPlayingTVSeriesState>(
          builder: (context, state) {
            if (state is NowPlayingTVSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NowPlayingTVSeriesSuccess) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.results[index];
                  return TVSeriesCard(tv);
                },
                itemCount: state.results.length,
              );
            } else if (state is NowPlayingTVSeriesError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
