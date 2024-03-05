import 'package:flutter/material.dart';
import 'package:netflixclone/Screens/searchActivity.dart';
import 'package:netflixclone/Screens/searchScreen.dart';
import 'package:netflixclone/module/moviemodule.dart';
import 'package:netflixclone/module/topratedTvmodule.dart';
import 'package:netflixclone/services/apiservices.dart';
import 'package:netflixclone/widgets/corauselWidget.dart';
import 'package:netflixclone/widgets/upcomingMoviecardwidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiServices apiservises = ApiServices();

  late Future<MovieModel> upcomingFuture;
  late Future<MovieModel> nowplaying;
  late Future<TopRatedTv> topratedTv;
  @override
  void initState() {
    super.initState();
    upcomingFuture = apiservises.getUpcomingMovie();
    nowplaying = apiservises.getNowplayingmovie();
    topratedTv = apiservises.getTopratedTv();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        titleSpacing: 0,
        backgroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset(
            'assets/logo.png',
            width: 130,
            height: 55,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearcheScreen()));
                },
                icon: Icon(
                  Icons.search,
                  size: 29,
                  color: Colors.white,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle, color: Colors.yellow)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            children: [
              FutureBuilder(
                  future: topratedTv,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                              const Color.fromARGB(255, 241, 22, 6)),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      return CourselWidget(data: snapshot.data!);
                    } else {
                      return SizedBox();
                    }
                  }),
              SizedBox(
                height: 220,
                child: UpcomingMovieCard(
                  future: nowplaying,
                  headlineText: "NowPlaying ",
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 220,
                child: UpcomingMovieCard(
                  future: upcomingFuture,
                  headlineText: "Upcoming Movies",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
