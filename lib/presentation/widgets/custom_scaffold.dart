import 'package:ditonton/presentation/pages/movie/search_movie_page.dart';
import 'package:ditonton/presentation/pages/tvseries/home_tvseries_page.dart';
import 'package:ditonton/presentation/pages/tvseries/search_tvseries_page.dart';
import 'package:flutter/material.dart';
import '../pages/about_page.dart';
import '../pages/watchlist_page.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold(
      {super.key, required this.pageTitle, required this.body});

  final Widget body;
  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$pageTitle'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                pageTitle == 'Movies'
                    ? SearchMoviePage.ROUTE_NAME
                    : SearchTVSeriesPage.ROUTE_NAME,
                arguments: pageTitle,
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('TV Series'),
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, HomeTVSeriesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      body: body,
    );
  }
}
