import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wlf/screens/content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wlf/widgets/appBar.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({Key key}) : super(key: key);

  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  final List<Color> colors = <Color>[
    Color(0xffB5EAD6),
    Color(0xffFFDAC0),
    Color(0xff00BEFC).withOpacity(0.5),
    Color(0xffF28686),
    Color(0xff60DCB7),
    Color(0xffF5E6BF),
    Color(0xffFEB7B1),
    Color(0xff60A0CF),
    Color(0xffFF9AA2),
    Color(0xffEEBC8F),
    Color(0xffF18DB7),
    Color(0xff6CD0D0),
    Color(0xffD78EF0),
    Color(0xffE2F0CC),
    Color(0xffF28686),
    Color(0xff7B78F2),
    Color(0xffC7CEEA),
  ];
  bool _visible = true;
  bool isScrollingDown = false;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    myScroll();
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {});
    super.dispose();
  }

  void myScroll() async {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
          _scrollController.position.pixels > 100) {
        if (!isScrollingDown) {
          setState(() {
            isScrollingDown = true;
            _visible = false;
          });
        }
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          setState(() {
            isScrollingDown = false;
            _visible = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: MyAppBar(_visible),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("blogs").snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  children: <Widget>[
                    ListView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(
                          bottom: 65.0,
                          top: 110,
                        ),
                        controller: _scrollController,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot _blog =
                              snapshot.data.documents[index];
                          int j;
                          if (index % 17 == 0) {
                            j = 0;
                          } else {
                            j = index;
                          }
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ContentPage(
                                    _blog.data["url"],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 170,
                              child: Card(
                                //shadowColor: Colors.blue,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                ),
                                margin: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      height: 170.0,
                                      //margin: EdgeInsets.all(2.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(0.0),
                                        color: colors[j],
                                        // image: DecorationImage(
                                        //   fit: BoxFit.fill,
                                        //   image: CachedNetworkImageProvider(
                                        //       _blog.data["image_url"]),
                                        // ),
                                      ),
                                    ),
                                    // Container(
                                    //   height: 390,
                                    //   padding: EdgeInsets.all(10.0),
                                    //   decoration: BoxDecoration(
                                    //     borderRadius:
                                    //         BorderRadius.circular(8.0),
                                    //     color: Colors.blue,
                                    //     gradient: LinearGradient(
                                    //       begin: FractionalOffset.topCenter,
                                    //       end: FractionalOffset.bottomCenter,
                                    //       colors: [
                                    //         Colors.black.withOpacity(0.27),
                                    //         Colors.black.withOpacity(0.27),
                                    //       ],
                                    //       stops: [0.0, 1.0],
                                    //     ),
                                    //   ),
                                    // ),
                                    Container(
                                      height: 170,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 12.0),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        _blog.data["title"].length > 60
                                            ? _blog.data["title"]
                                                    .substring(0, 60) +
                                                '...'
                                            : _blog.data["title"],
                                        style: TextStyle(
                                            fontFamily: 'NHGTX',
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.030,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Colors.black.withOpacity(0.4)),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Container(
                                      height: 170,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 12.0),
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        "- " + _blog.data["author"],
                                        style: TextStyle(
                                            fontFamily: 'NHGTX',
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.021,
                                            color:
                                                Colors.black.withOpacity(0.4)),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ],
                );
        },
      ),
    );
  }
}
