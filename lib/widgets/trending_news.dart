import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/models/news_channel_headlines_model.dart';
import 'package:newsapp/view/news_detail.dart';
import 'package:newsapp/view_model/news_view_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TrendingNewsWidget extends StatelessWidget {
  TrendingNewsWidget({super.key});

  final NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat("MMMM dd yyyy");

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;

    return FutureBuilder<NewsChannelsHeadlinesModel>(
      future: newsViewModel.fetchNewsChannelHeadlinesApi(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: SpinKitFadingCircle(color: Colors.black, size: 50),
          );
        }

        final articles = snapshot.data?.articles;
        if (articles == null || articles.isEmpty) {
          return Center(child: Text("No Data available."));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Trending',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.35,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  if (article.urlToImage == null || article.title == null) {
                    return SizedBox.shrink();
                  }

                  final date =
                      DateTime.tryParse(article.publishedAt ?? '') ??
                      DateTime.now();

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
                    child: Container(
                      height: height * 0.3,
                      width: width * .9,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl: article.urlToImage ?? '',
                              fit: BoxFit.fill,
                              height: height * 0.2,
                              width: double.infinity,
                              placeholder:
                                  (context, url) => SpinKitFadingCircle(
                                    color: Colors.black,
                                    size: 50,
                                  ),
                              errorWidget:
                                  (context, url, error) =>
                                      Icon(Icons.error, color: Colors.red),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                article.description ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: const EdgeInsets.all(9.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      article.source?.name ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    format.format(date),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
