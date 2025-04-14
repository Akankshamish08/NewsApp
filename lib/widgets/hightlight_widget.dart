import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/view/news_detail.dart';
import '../models/categories_news_model.dart';
import '../view_model/news_view_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HighlightsWidget extends StatelessWidget {
  final String category;

  HighlightsWidget({super.key, required this.category});

  final NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat("MMMM dd yyyy");

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return FutureBuilder<CategoriesNewsModel>(
      future: newsViewModel.fetchCategoriesNewsApi(category),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: SpinKitFadingCircle(color: Colors.black, size: 50),
          );
        }

        final articles = snapshot.data?.articles;
        if (articles == null || articles.isEmpty) {
          return Center(child: Text('No Data available.'));
        }

        return ListView.builder(
          itemCount: articles.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final article = articles[index];
            if (article.title == null || article.urlToImage == null) {
              return SizedBox.shrink();
            }

            final date =
                DateTime.tryParse(article.publishedAt ?? '') ?? DateTime.now();

            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => NewsDetail(
                          newsImage: article.urlToImage ?? '',
                          newsTitle: article.title ?? '',
                          newsDate: article.publishedAt ?? '',
                          author: article.author ?? '',
                          description: article.description ?? '',
                          content: article.content ?? '',
                          source: article.source?.name ?? '',
                        ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: article.urlToImage ?? '',
                        fit: BoxFit.fill,
                        height: height * .10,
                        width: width * .3,
                        placeholder:
                            (context, url) => Center(
                              child: SpinKitFadingCircle(
                                color: Colors.black,
                                size: 50,
                              ),
                            ),
                        errorWidget:
                            (context, url, error) =>
                                Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: height * .1,
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                article.title ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    article.source?.name ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  format.format(date),
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
