// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:netflixclone/common/utils.dart';
import 'package:netflixclone/module/detailTvseriesmodule.dart';
import 'package:netflixclone/module/detailmoviemodule.dart';
import 'package:netflixclone/module/popularmoviemodel.dart';
import 'package:netflixclone/services/apiservices.dart';

// ignore: must_be_immutable
class DetailTVScreen extends StatefulWidget {
  int tvid;
  DetailTVScreen({
    Key? key,
    required this.tvid,
  }) : super(key: key);

  @override
  State<DetailTVScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailTVScreen> {
  ApiServices apiServices = ApiServices();
  late Future<MovieRecommendationModel> movierocommendations;
  late Future<DetailTvSereisModule> tvdetail;
  @override
  void initState() {
    detailtvdata();

    super.initState();
  }

  void detailtvdata() {
    tvdetail = apiServices.getTvDetails(widget.tvid);
    movierocommendations = apiServices.getMovieRecommendation(widget.tvid);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('movieid: ${widget.tvid}');

    return Scaffold(
        body: SingleChildScrollView(
      child: FutureBuilder(
          future: tvdetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var tv = snapshot.data;
              String genera = tv!.genres.map((e) => e.name).join(', ');
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
                                image:
                                    NetworkImage("${imageUrl}${tv.posterPath}"),
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
                          tv.name,
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
                              tv.lastAirDate.year.toString(),
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
                          tv.overview,
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
                                                          DetailTVScreen(
                                                              tvid: widget
                                                                  .tvid)));
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
