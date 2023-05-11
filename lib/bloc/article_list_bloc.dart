import 'dart:async';

import 'package:bloc_demo/data/rw_client.dart';

import '../data/article.dart';
import 'bloc.dart';

class ArticleListBloc implements Bloc {
  // Create an instance of RWClient to communicate with API
  final _client = RWClient();

  // StreamController declaration manages the input sink for this BLoC
  final _searchQueryController = StreamController<String?>();

  // Public sink interface to send events to the BLoC
  Sink<String?> get searchQuery => _searchQueryController;

  late Stream<List<Article>?> articlesStream;

  ArticleListBloc() {
    // Process input queries sink and build an output stream with an article's list
    articlesStream = _searchQueryController.stream
        .asyncMap((query) => _client.fetchArticles(query));
  }

// Cleanup method to close the StreamController
  @override
  void dispose() {
    _searchQueryController.close();
  }
}
