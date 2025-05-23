import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miniprojectmovieapp/config/approute.dart';
import 'package:miniprojectmovieapp/config/network_service.dart';
import 'package:miniprojectmovieapp/model/keyword_model.dart';
import 'package:miniprojectmovieapp/provider/favorite_provider.dart';
import 'package:provider/provider.dart';

import '../../model/airing_model.dart';
import '../../model/toprate_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  Future<AiringModel>? _AiringModel;
  Future<ToprateModel>? _ToprareModel;
  Future<KeywordModel>? _keyword;
  TextEditingController _textEditingController = TextEditingController();
  String search = '';
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _AiringModel = ServiceNetwork().getAiringDio();
    _ToprareModel = ServiceNetwork().getTopRateDio();

    super.initState();
  }

  // onSearch(String search) {

  // }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoriteProvider>(context);
    log('tv ${provider.favoriteList}');

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
            Padding(
              padding: const EdgeInsets.all(12),
              child: TabBar(
                unselectedLabelStyle: null,
                controller: _tabController,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.amberAccent,
                // indicator: BoxDecoration(
                //   color: Colors.amberAccent, // สีของ indicator
                //   borderRadius:
                //       BorderRadius.circular(20), // มุมโค้งของ indicator
                // ),
                indicatorPadding: EdgeInsets.zero, // ลบ padding ของ indicator
                indicatorSize: TabBarIndicatorSize
                    .tab, // ให้ indicator ครอบคลุมพื้นที่แท็บ
                tabs: [
                  Tab(
                    text: 'Airing Today',
                  ),
                  Tab(
                    text: 'Top Rated',
                  ),
                  Tab(
                    text: 'Favorite',
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
                      var filteredData = snapshot.data!.results!
                          .where((item) => item.name!.toLowerCase().contains(
                              _textEditingController.text.toLowerCase()))
                          .toList();

                      return GridView.builder(
                          itemCount: filteredData.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.68,
                            mainAxisExtent: 290,
                          ),
                          itemBuilder: (context, index) {
                            var tv = filteredData[index];
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
                          });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                FutureBuilder(
                  future: _ToprareModel,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var filteredData = snapshot.data!.results!
                          .where((item) => item.name!.toLowerCase().contains(
                              _textEditingController.text.toLowerCase()))
                          .toList();
                      return GridView.builder(
                        itemCount: filteredData.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.68,
                          mainAxisExtent: 290,
                        ),
                        itemBuilder: (context, index) {
                          var tv = filteredData[index];
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

                // Tab 3: Favorite
                Consumer<FavoriteProvider>(
                  builder: (context, provider, child) {
                    var filteredData = provider.favoriteList
                        .where((item) => item.name!.toLowerCase().contains(
                            _textEditingController.text.toLowerCase()))
                        .toList();
                    if (filteredData.isEmpty) {
                      return Center(
                        child: Text(
                          'No favorites added yet!',
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 16),
                        ),
                      );
                    }

                    return GridView.builder(
                      itemCount: filteredData.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.68,
                        mainAxisExtent: 290,
                      ),
                      itemBuilder: (context, index) {
                        var tv = filteredData[index];
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
                                          (tv.posterPath ?? ''),
                                      height: 110,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      tv.name ?? '',
                                      style: GoogleFonts.poppins(
                                          fontSize: 16, color: Colors.white),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5, left: 10, right: 10),
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
                      },
                    );
                  },
                ),

                // Text('dsdfsdfsdfsda',style: TextStyle(color: Colors.white),),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class DefaultTabControllerExample extends StatelessWidget {
  const DefaultTabControllerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Airing Today'),
                Tab(text: 'Top Rated'),
                Tab(text: 'Save'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Center(child: Text('Airing Today')),
                  Center(child: Text('Top Rated')),
                  Center(child: Text('Save')),
                ],
              ),
            ),
          ],
        ));
  }
}
