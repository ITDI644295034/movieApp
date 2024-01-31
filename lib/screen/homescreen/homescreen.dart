import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miniprojectmovieapp/config/approute.dart';
import 'package:miniprojectmovieapp/config/network_service.dart';
import 'package:miniprojectmovieapp/model/keyword_model.dart';

import '../../model/airing_model.dart';
import '../../model/toprate_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  Future<AiringModel>? _AiringModel;
  Future<ToprateModel>? _ToprareModel;
  Future<KeywordModel>? _keyword;
  TextEditingController _textEditingController = TextEditingController();
  String search = '';
  @override
  void initState() {
    _AiringModel = ServiceNetwork().getAiringDio();
    _ToprareModel = ServiceNetwork().getTopRateDio();
    super.initState();
  }

  // onSearch(String search) {

  // }
  @override
  Widget build(BuildContext context) {
    final TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      backgroundColor: Colors.black38,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      'Watch Movie',
                      style: GoogleFonts.poppins(
                          fontSize: 34, color: Colors.white),
                    ),
                  ),
                  Container(
                    width: 110,
                    child: TextField(
                      controller: _textEditingController,
                      onChanged: (String? value) => {
                        print(value),
                        setState(() {
                          search = value.toString();
                        })
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.search),
                        suffixIconColor: Colors.white,
                      ),
                      style: GoogleFonts.poppins(color: Colors.red),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              height: 45,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(50)),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    text: 'Airing Today',
                  ),
                  Tab(
                    text: 'Top Rated',
                  ),
                  Tab(
                    text: 'Save',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: TabBarView(
              controller: _tabController,
              children: [
                FutureBuilder(
                  future: _AiringModel,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        itemCount: snapshot.data?.results?.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.68,
                          mainAxisExtent: 290,
                        ),
                        itemBuilder: (context, index) {
                          var position = index.toString();
                          var tv = snapshot.data!.results?[index];
                          if (_textEditingController.text.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.all(12),
                              child: GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, AppRoute.detailRoute,
                                    arguments: tv),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white12,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                          child: Image.network(
                                            'https://image.tmdb.org/t/p/w500' +
                                                (tv?.posterPath ?? ''),
                                            height: 110,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          tv!.name ?? '',
                                          style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              color: Colors.white),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5,
                                            bottom: 5,
                                            left: 10,
                                            right: 10),
                                        child: RatingStars(
                                          valueLabelVisibility: false,
                                          maxValue: 10,
                                          starSize: 10,
                                          starCount: tv.voteAverage!.toInt(),
                                          value: tv.voteAverage!.toDouble(),
                                        ),
                                      ),
                                      Flexible(
                                          child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(tv.overview ?? '',
                                            style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                color: Colors.grey),
                                            maxLines: 3,
                                            overflow: TextOverflow.fade,
                                            softWrap: true),
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }

                         else if (tv!.name!.toLowerCase().toString().contains(_textEditingController.text.toLowerCase())) {
                            return Padding(
                            padding: const EdgeInsets.all(12),
                            child: GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, AppRoute.detailRoute,
                                  arguments: tv),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                        child: Image.network(
                                          'https://image.tmdb.org/t/p/w500' +
                                              (tv?.posterPath ?? ''),
                                          height: 110,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        tv!.name ?? '',
                                        style: GoogleFonts.poppins(
                                            fontSize: 16, color: Colors.white),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                          left: 10,
                                          right: 10),
                                      child: RatingStars(
                                        valueLabelVisibility: false,
                                        maxValue: 10,
                                        starSize: 10,
                                        starCount: tv.voteAverage!.toInt(),
                                        value: tv.voteAverage!.toDouble(),
                                      ),
                                    ),
                                    Flexible(
                                        child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(tv.overview ?? '',
                                          style: GoogleFonts.poppins(
                                              fontSize: 10, color: Colors.grey),
                                          maxLines: 3,
                                          overflow: TextOverflow.fade,
                                          softWrap: true),
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          );
                          }
                          else{
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Container();
                  },
                ),
                FutureBuilder(
                  future: _ToprareModel,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        itemCount: snapshot.data?.results?.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.68,
                          mainAxisExtent: 290,
                        ),
                        itemBuilder: (context, index) {
                          var tv = snapshot.data!.results?[index];
                          return Padding(
                            padding: const EdgeInsets.all(12),
                            child: GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, AppRoute.detailTopRoute,
                                  arguments: tv),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                        child: Image.network(
                                          'https://image.tmdb.org/t/p/w500' +
                                              (tv?.posterPath ?? ''),
                                          height: 110,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        tv!.name ?? '',
                                        style: GoogleFonts.poppins(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                          left: 10,
                                          right: 10),
                                      child: RatingStars(
                                        valueLabelVisibility: false,
                                        starSize: 5,
                                        starCount: 5,
                                        value: tv.voteAverage!.toDouble(),
                                      ),
                                    ),
                                    Flexible(
                                        child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(tv.overview ?? '',
                                          style: GoogleFonts.poppins(
                                              fontSize: 10, color: Colors.grey),
                                          maxLines: 3,
                                          overflow: TextOverflow.fade,
                                          softWrap: true),
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                // Center(
                //   child: Text(
                //     'Save',
                //     style: TextStyle(color: Colors.white),
                //   ),
                // ),

                Center(
                  child: Container(
                    child: Text(
                      'Save',
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                )

                // Text('dsdfsdfsdfsda',style: TextStyle(color: Colors.white),),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
