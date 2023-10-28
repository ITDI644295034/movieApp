import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miniprojectmovieapp/config/approute.dart';
import 'package:miniprojectmovieapp/config/network_service.dart';
import 'package:miniprojectmovieapp/model/toprate_model.dart';
import 'package:share_plus/share_plus.dart';

import '../config/api.dart';
import '../model/keyword_model.dart';

class DetailTopRate extends StatefulWidget {
  const DetailTopRate({super.key});

  @override
  State<DetailTopRate> createState() => _DetailTopRateState();
}

class _DetailTopRateState extends State<DetailTopRate> {
  Result? _movieModel;
  Future<KeywordModel>? _mvModel;
  String? _id;

  @override
  void initState() {
    _movieModel = Result();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Object? arguments = ModalRoute.of(context)!.settings.arguments;
    _id = arguments.toString();
    if (arguments is Result) {
      _movieModel = arguments;
      _mvModel =
          ServiceNetwork().getKeywordDio(_movieModel?.id.toString() as String);
    }
    return Scaffold(
      backgroundColor: Colors.black38,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Stack(
              // alignment: Alignment.center,
              children: <Widget>[
                Image.network(
                  'https://image.tmdb.org/t/p/w500' +
                      (_movieModel?.posterPath ?? ''),
                  height: 190,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                          Navigator.of(context).pushNamed(AppRoute.homeRoute);  
                          });
                          
                          // Navigator.pushNamed(context, AppRoute.homeRoute);
                        },
                        icon: Icon(
                          Icons.navigate_before,
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.bookmark_border,
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _movieModel?.name ?? '',
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 26),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RatingStars(
                      valueLabelVisibility: false,
                      maxValue: 10,
                      starSize: 10,
                      starCount: _movieModel!.voteAverage!.toInt(),
                      value: _movieModel!.voteAverage!.toDouble(),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
              child: FutureBuilder(
                future: _mvModel,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 50,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data?.results?.length,
                        itemBuilder: (context, index) {
                          var keyword = snapshot.data!.results?[index];
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: Colors.grey.shade600),
                                alignment: Alignment.center,
                                // color: Colors.red,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    keyword!.name ?? '',
                                    style: GoogleFonts.poppins(
                                        color: Colors.black),
                                  ),
                                )),
                          );
                        },
                      ),
                    );
                  } else
                    return Text(
                      '$snapshot',
                      style: TextStyle(color: Colors.white),
                    );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
              child: Container(
                child: Text(
                  'Story Line',
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 26),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 35,
              ),
              child: Container(
                child: ListTile(
                  title: Text(
                    _movieModel?.overview ?? '',
                    style: GoogleFonts.poppins(color: Colors.white),
                    maxLines: 7,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 35),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonBar(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.volume_down),
                        color: Colors.green,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.volume_off),
                        color: Colors.yellow,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.favorite_border),
                        color: Colors.red,
                      ),
                      IconButton(
                        onPressed: () {
                          Share.share(API.URLBASE +
                              _movieModel!.id.toString() +
                              '?api_key=b4e1da8db33117e80ca69a5af4b7bc3e&language=en-US&page=1');
                        },
                        icon: Icon(Icons.share),
                        color: Colors.blue,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoute.vdoRoute,
              arguments: _movieModel?.id);
        },
        child: Text('VDO'),
      ),
    );
  }
}
