import 'package:flutter/material.dart';
import 'package:netflixclone/Screens/detailmovieActivity.dart';
import 'package:netflixclone/common/utils.dart';
import 'package:netflixclone/module/moviemodule.dart';

class UpcomingMovieCard extends StatelessWidget {
  final Future<MovieModel> future;
  final String headlineText;
  UpcomingMovieCard({
    Key? key,
    required this.future,
    required this.headlineText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!.results;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    headlineText,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailMovieScreen(
                                            movieid: data[index].id)));
                              },
                              child: Image.network(
                                '$imageUrl${data[index].posterPath}',
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            );
          } else {
            return SizedBox.shrink();
          }
        }));
  }
}
