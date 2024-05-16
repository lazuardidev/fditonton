import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/presentation/pages/tvseries/now_playing_tvseries_page.dart';
import 'package:ditonton/presentation/pages/tvseries/popular_tvseries_page.dart';
import 'package:ditonton/presentation/pages/tvseries/top_rated_tvseries_page.dart';
import 'package:ditonton/presentation/pages/tvseries/tvseries_detail_page.dart';
import 'package:ditonton/presentation/provider/tvseries/tvseries_list_notifier.dart';
import 'package:ditonton/presentation/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/constants.dart';
import '../../../common/state_enum.dart';

class HomeTVSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/tvseries';
  const HomeTVSeriesPage({super.key});

  @override
  State<HomeTVSeriesPage> createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<TVSeriesListNotifier>(context, listen: false)
          ..fetchNowPlayingTV()
          ..fetchPopularTV()
          ..fetchTopRatedTV());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      pageTitle: 'TV Series',
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Now Playing',
                onTap: () => Navigator.pushNamed(
                    context, NowPlayingTVSeriesPage.ROUTE_NAME),
              ),
              Consumer<TVSeriesListNotifier>(builder: (context, data, child) {
                final state = data.nowPlayingState;
                if (state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TVList(data.nowPlayingTv);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(
                    context, PopularTVSeriesPage.ROUTE_NAME),
              ),
              Consumer<TVSeriesListNotifier>(builder: (context, data, child) {
                final state = data.popularState;
                if (state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TVList(data.popularTv);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(
                    context, TopRatedTSeriesPage.ROUTE_NAME),
              ),
              Consumer<TVSeriesListNotifier>(builder: (context, data, child) {
                final state = data.topRatedState;
                if (state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TVList(data.topRatedTV);
                } else {
                  return const Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TVList extends StatelessWidget {
  final List<TVSeries> tvSeries;

  const TVList(this.tvSeries, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TVSeriesDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
