import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsDetail extends StatefulWidget {
  final String newsImage,
      newsTitle,
      newsDate,
      author,
      description,
      content,
      source;
  const NewsDetail({
    Key? key,
    required this.newsImage,
    required this.newsTitle,
    required this.newsDate,
    required this.author,
    required this.description,
    required this.content,
    required this.source,
  }) : super(key: key);

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  final format = new DateFormat('MMMM dd yyyy');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    DateTime dateTime = DateTime.parse(widget.newsDate);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Stack(
        children: [
          Container(
            height: height * .45,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: CachedNetworkImage(
                imageUrl: widget.newsImage,
                fit: BoxFit.cover,
                placeholder:
                    (context, url) =>
                        Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          Container(
            height: height * .6,
            margin: EdgeInsets.only(top: height * .4),
            padding: EdgeInsets.only(top: 20,right: 20,left: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              
            ),
            child: ListView(
              children: [
                Text(widget.newsTitle,style: GoogleFonts.poppins(fontSize: 20,color: Colors.black87,fontWeight: FontWeight.w700),),
                SizedBox(height: height*.02,),
                Row(
                  children: [
                    Expanded(child: Text(widget.author , style: GoogleFonts.poppins(fontSize: 13,color: Colors.black87,fontWeight: FontWeight.w700),)),
                    Text(format.format(dateTime) , style: GoogleFonts.poppins(fontSize: 12,color: Colors.black87,fontWeight: FontWeight.w500),)
                  ],
                ),
                SizedBox(height: height*.03,),
                Text(widget.description , style: GoogleFonts.poppins(fontSize: 13,color: Colors.black87,fontWeight: FontWeight.w500),)

              ],
            ),
          )
        ],
      ),
    );
  }
}
