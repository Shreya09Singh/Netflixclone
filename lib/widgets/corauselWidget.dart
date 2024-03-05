// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/Screens/detailmovieActivity.dart';
import 'package:netflixclone/Screens/detailtvScreen.dart';
import 'package:netflixclone/common/utils.dart';

import 'package:netflixclone/module/topratedTvmodule.dart';

class CourselWidget extends StatelessWidget {
  const CourselWidget({
    Key? key,
    required this.data,
  }) : super(key: key);
  final TopRatedTv data;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var carouselOption = CarouselOptions(
        height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
        aspectRatio: 16 / 9,
        autoPlay: true,
        reverse: false,
        enableInfiniteScroll: true,
        initialPage: 0,
        viewportFraction: 0.9,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal);
    return SizedBox(
      width: size.width,
      height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
      child: CarouselSlider.builder(
          itemCount: data.results.length,
          itemBuilder: (context, index, int realIndex) {
            var url = data.results[index].backdropPath.toString();
            return GestureDetector(
              child: Column(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailMovieScreen(
                                    movieid: data.results[index].id)));
                      },
                      child: CachedNetworkImage(imageUrl: '$imageUrl$url')),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${data.results[index].name}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            );
          },
          options: carouselOption),
    );
  }
}
