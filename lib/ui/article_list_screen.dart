import 'package:bloc_demo/bloc/article_detail_bloc.dart';
import 'package:bloc_demo/ui/article_detail_screen.dart';
import 'package:bloc_demo/ui/article_list_item.dart';
import 'package:flutter/material.dart';

import '../bloc/article_list_bloc.dart';
import '../bloc/bloc_provider.dart';
import '../data/article.dart';

class ArticleListScreen extends StatefulWidget {
  const ArticleListScreen({super.key});

  @override
  State<ArticleListScreen> createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 10))
      ..addListener(() {
        setState(() {});
      });
    animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Variable to instanciate an ArticleListBloc.
    // BlocProvider allows to find the required BLoC from the widget tree.
    final bloc = BlocProvider.of<ArticleListBloc>(context);

    return Scaffold(
      appBar: AppBar(
          title: const Text('Articles'), backgroundColor: Colors.cyan[200]),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Search...'),
            // Submit text to ArticleListBloc
            onChanged: bloc.searchQuery.add,
          ),
        ),
        Expanded(child: _buildResults(bloc))
      ]),
    );
  }

  /// StreamBuilder execute builder closure and update the widget tree when receives new events.
  /// For this reason, isn't required to call setState() in this case

  Widget _buildResults(ArticleListBloc bloc) {
    // StreamBuilder defines the stream property using ArticleListBloc to understand where
    // to get the article list.
    return StreamBuilder<List<Article>?>(
      stream: bloc.articlesStream,
      builder: (context, snapshot) {
        // If there is not data or list, Loading messages is displayed
        // If there is a list, but empty, No Results messages is displayed
        final results = snapshot.data;
        if (results == null) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LinearProgressIndicator(value: animationController.value),
              ],
            ),
          );
          //return const Center(child: Text('Loading...'));
        } else if (results.isEmpty) {
          return const Center(child: Text('No Results...'));
        }
        // It passes the result of the search to _buildSearchResults method
        return _buildSearchResults(results);
      },
    );
  }

  Widget _buildSearchResults(List<Article> results) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final article = results[index];
        return InkWell(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),

            // This widget shows details of articles in the list
            child: ArticleListItem(article: article),
          ),
          onTap: () {
            // Redirect user to an article's details page
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                        bloc: ArticleDetailBloc(id: article.id),
                        child: const ArticleDetailScreen())));
          },
        );
      },
    );
  }
}
