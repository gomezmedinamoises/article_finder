import 'package:bloc_demo/data/article_formatter_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../data/article.dart';

class ArticleDetail extends StatelessWidget {
  final Article article;

  ArticleDetail(this.article);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.attributes?.cardArtworkUrl != null) ...[
              const SizedBox(width: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  width: 150,
                  height: 150,
                  imageUrl: article.attributes!.cardArtworkUrl!,
                ),
              ),
            ],
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      article.attributes?.name ?? '',
                      style: textTheme.titleMedium,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        article.subscriptionType,
                        style: textTheme.titleSmall,
                      ),
                    ),
                    if (article.formattedReleaseDate != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          article.formattedReleaseDate!,
                          //article.attributes.formattedReleaseDate!,
                          style: textTheme.titleSmall,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (article.attributes?.description != null)
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: Text(
              article.attributes!.description!,
              style: textTheme.titleMedium,
            ),
          ),
        if (article.attributes?.contributorString != null)
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: Text(
              article.attributes!.contributorString!,
              style: textTheme.titleMedium,
            ),
          ),
        if (article.attributes?.technologyTripleString != null)
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
            child: Text(
              article.attributes!.technologyTripleString!,
              style: textTheme.titleSmall,
            ),
          )
      ],
    );
  }
}
