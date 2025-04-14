import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/view_model/news_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:newsapp/view/news_detail.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final NewsViewModel _newsViewModel = NewsViewModel();
  bool _isLoading = false;
  List _articles = [];

  void _searchNews() async {
    setState(() {
      _isLoading = true;
    });

    final result = await _newsViewModel.fetchNewsByQuery(_controller.text.trim());
    setState(() {
      _articles = result?.articles ?? [];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,

                    decoration: InputDecoration(
                        hintText: "Search news ",

                      border: OutlineInputBorder(),

                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchNews,
                ),
              ],
            ),

            SizedBox(height: 16),


            _isLoading
                ? Center(child: CircularProgressIndicator())
                : _articles.isEmpty
                ? Text('No results', style: GoogleFonts.poppins())
                : Expanded(
              child: ListView.builder(
                itemCount: _articles.length,
                itemBuilder: (context, index) {
                  final article = _articles[index];
                  return ListTile(
                    leading: article.urlToImage != null
                        ? CachedNetworkImage(
                      imageUrl: article.urlToImage,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    )
                        : null,
                    title: Text(article.title ?? '', style: GoogleFonts.poppins()),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NewsDetail(
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
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
