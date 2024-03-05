// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:netflixclone/common/utils.dart';
import 'package:netflixclone/module/detailmoviemodule.dart';
import 'package:netflixclone/module/popularmoviemodel.dart';
import 'package:netflixclone/services/apiservices.dart';

// ignore: must_be_immutable
class DetailMovieScreen extends StatefulWidget {
  int movieid;
  DetailMovieScreen({
    Key? key,
    required this.movieid,
  }) : super(key: key);

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  ApiServices apiServices = ApiServices();
  late Future<MovieRecommendationModel> movierocommendations;
  late Future<DetailMovieModel> moviedetail;
  @override
  void initState() {
    detailmoviedata();

    super.initState();
  }

  void detailmoviedata() {
    moviedetail = apiServices.getMovieDetails(widget.movieid);
    movierocommendations = apiServices.getMovieRecommendation(widget.movieid);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('movieid: ${widget.movieid}');

    return Scaffold(
        body: SingleChildScrollView(
      child: FutureBuilder(
          future: moviedetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var movie = snapshot.data;
              String genera = movie!.genres.map((e) => e.name).join(', ');
              return Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blueGrey.withOpacity(.5),
                                  blurRadius: 27,
                                  spreadRadius: 25)
                            ],
                            image: DecorationImage(
                                image: NetworkImage(
                                    "${imageUrl}${movie.posterPath}"),
                                fit: BoxFit.cover)),
                        child: SafeArea(
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                    size: 28,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              movie.releaseDate.year.toString(),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 17),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Expanded(
                              child: Text(
                                genera,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 17),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Text(
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          movie.overview,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FutureBuilder(
                      future: movierocommendations,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var recomendeddata = snapshot.data;
                          return recomendeddata!.results.isEmpty
                              ? SizedBox()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("More Like This"),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    GridView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount:
                                            recomendeddata.results.length,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                // crossAxisSpacing: 10,
                                                mainAxisSpacing: 15,
                                                childAspectRatio: 1.5 / 2,
                                                crossAxisCount: 3),
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailMovieScreen(
                                                              movieid:
                                                                  recomendeddata
                                                                      .results[
                                                                          index]
                                                                      .id)));
                                            },
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  '${imageUrl}${recomendeddata.results[index].posterPath}',
                                            ),
                                          );
                                        })
                                  ],
                                );
                        }

                        return Text("Error");
                      })
                ],
              );
            } else {
              return SizedBox();
              // return CircularProgressIndicator();
            }
          }),
    ));
  }
}
