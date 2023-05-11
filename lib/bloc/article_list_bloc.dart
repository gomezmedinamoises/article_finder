import 'dart:async';

import 'package:bloc_demo/data/rw_client.dart';
import 'package:rxdart/rxdart.dart';

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
        .startWith(null) // Produces an empty query to start loading all articles
        .debounceTime(const Duration(milliseconds: 100))
        .switchMap(
          (query) => _client.fetchArticles(query)
            .asStream() // Convert Future to Stream
            .startWith(null) // Send a null event to the article output at the start of every request
        );
  }

// Cleanup method to close the StreamController
  @override
  void dispose() {
    _searchQueryController.close();
  }
}
