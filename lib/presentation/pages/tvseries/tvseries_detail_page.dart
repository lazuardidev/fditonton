import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries_detail.dart';
import 'package:ditonton/presentation/bloc/tvseries/detail/tvseries_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries/recomendation/tvseries_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries/watchlist/tvseries_watchlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TVSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tvseries';

  final int id;
  const TVSeriesDetailPage({super.key, required this.id});

  @override
  State<TVSeriesDetailPage> createState() => _TVSeriesDetailPageState();
}

class _TVSeriesDetailPageState extends State<TVSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TVSeriesDetailBloc>(context)
        .add(LoadTVSeriesDetail(widget.id));
    BlocProvider.of<TVSeriesRecommendationBloc>(context)
        .add(LoadTVSeriesRecommendations(widget.id));
    BlocProvider.of<TVSeriesWatchlistBloc>(context)
        .add(LoadWatchListStatus(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    final isAddedToWatchList = context.select<TVSeriesWatchlistBloc, bool>(
      (bloc) => (bloc.state is WatchListStatusAdded)
          ? (bloc.state as WatchListStatusAdded).isAddedToWatchList
          : false,
    );
    return Scaffold(
      body: BlocBuilder<TVSeriesDetailBloc, TVSeriesDetailState>(
        builder: (context, state) {
          if (state is TVSeriesDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TVSeriesDetailSuccess) {
            return SafeArea(
              child: DetailContent(
                state.result,
                isAddedToWatchList,
              ),
            );
          } else if (state is TVSeriesDetailError) {
            return Text(state.message);
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TVSeriesDetail tv;
  final bool isAddedWatchlist;

  const DetailContent(this.tv, this.isAddedWatchlist, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tv.name,
                              style: kHeading5,
                            ),
                            BlocConsumer<TVSeriesWatchlistBloc,
                                TVSeriesWatchlistState>(
                              listener: (context, state) {
                                if (state is SuccessMessage) {
                                  BlocProvider.of<TVSeriesWatchlistBloc>(
                                          context)
                                      .add(LoadWatchListStatus(tv.id));
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(state.message)));
                                } else if (state is FailedMessage) {
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(state.message)));
                                }
                              },
                              builder: (context, state) {
                                return ElevatedButton(
                                  onPressed: () async {
                                    if (!isAddedWatchlist) {
                                      BlocProvider.of<TVSeriesWatchlistBloc>(
                                              context)
                                          .add(AddWatchList(tv));
                                    } else {
                                      BlocProvider.of<TVSeriesWatchlistBloc>(
                                              context)
                                          .add(RemoveFromWatchList(tv));
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      isAddedWatchlist
                                          ? const Icon(Icons.check)
                                          : const Icon(Icons.add),
                                      const Text('Watchlist'),
                                    ],
                                  ),
                                );
                              },
                            ),
                            Text(
                              _showGenres(tv.genres),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tv.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tv.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Current Season',
                              style: kHeading6,
                            ),
                            const SizedBox(height: 6),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16)),
                                  child: CachedNetworkImage(
                                    width: 120,
                                    imageUrl:
                                        '$BASE_IMAGE_URL${tv.seasons.last.posterPath}',
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tv.seasons.last.name,
                                        style: kSubtitle,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: kMikadoYellow,
                                            size: 24,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                              '${tv.seasons.last.voteAverage}'),
                                          const SizedBox(width: 5),
                                          const Text('•'),
                                          const SizedBox(width: 5),
                                          Text(
                                              '${tv.seasons.last.episodeCount} Episodes'),
                                        ],
                                      ),
                                      Text(tv.seasons.last.overview),
                                      const SizedBox(height: 6),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TVSeriesRecommendationBloc,
                                TVSeriesRecommendationState>(
                              builder: (context, state) {
                                if (state is TVSeriesRecommendationLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is TVSeriesRecommendationError) {
                                  return Text(state.message);
                                } else if (state
                                    is TVSeriesRecommendationsSuccess) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tv = state.recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TVSeriesDetailPage.ROUTE_NAME,
                                                arguments: tv.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.recommendations.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
