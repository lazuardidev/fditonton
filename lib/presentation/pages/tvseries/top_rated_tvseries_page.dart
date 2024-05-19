import 'package:ditonton/presentation/bloc/tvseries/top_rated_tvseries_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/tvseries_card_list.dart';

class TopRatedTSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tvseries';
  const TopRatedTSeriesPage({super.key});

  @override
  State<TopRatedTSeriesPage> createState() => _TopRatedTVSeriesPageState();
}

class _TopRatedTVSeriesPageState extends State<TopRatedTSeriesPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TopRatedTVSeriesBloc>(context).add(LoadTopRatedTVSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
          builder: (context, state) {
            if (state is TopRatedTVSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTVSeriesSuccess) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.results[index];
                  return TVSeriesCard(tv);
                },
                itemCount: state.results.length,
              );
            } else if (state is TopRatedTVSeriesError) {
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
