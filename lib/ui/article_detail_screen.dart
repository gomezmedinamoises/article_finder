import 'package:flutter/material.dart';

import '../bloc/article_detail_bloc.dart';
import '../bloc/bloc_provider.dart';
import '../data/article.dart';
import 'article_detail.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ArticleDetailBloc>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Articles detail'), backgroundColor: Colors.cyan[200]),
      body: Container(alignment: Alignment.center, child: _buildContent(bloc)),
    );
  }
}

Widget _buildContent(ArticleDetailBloc bloc) {
  return StreamBuilder<Article?>(
    stream: bloc.articleStream,
    builder: (context, snapshot) {
      final article = snapshot.data;
      if (article == null) {
        return Center(child: CircularProgressIndicator());
      }

      return ArticleDetail(article);
    },
  );
}
