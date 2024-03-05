import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netflixclone/Screens/detailmovieActivity.dart';

import 'package:netflixclone/common/utils.dart';
import 'package:netflixclone/module/popularmoviemodel.dart';
import 'package:netflixclone/module/searchModel.dart';
import 'package:netflixclone/services/apiservices.dart';

class SearcheScreen extends StatefulWidget {
  const SearcheScreen({super.key});

  @override
  State<SearcheScreen> createState() => _SearcheScreenState();
}

class _SearcheScreenState extends State<SearcheScreen> {
  ApiServices apiServices = ApiServices();
  TextEditingController searchcontroller = TextEditingController();
  SearchModel? seachmovies;
  late Future<MovieRecommendationModel> popularmovie;

  void search(String query) {
    apiServices.getSearchMovie(query).then((value) {
      setState(() {
        seachmovies = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    popularmovie = apiServices.getPopuparmovie();
    super.initState();
  }

  // void popmovie() {
  //   setState(() {
  //     popularmovie = apiServices.getPopuparmovie();
  //   });
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchcontroller.dispose();
  }

  void clear() {
    searchcontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 50,
                  child: TextFormField(
                    controller: searchcontroller,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              clear();
                            },
                            icon: Icon(Icons.cancel)),
                        prefixIcon: Icon(
                          Icons.search,
                          size: 26,
                        ),
                        hintText: "search",
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none)),
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    onChanged: (value) {
                      if (value.isEmpty) {
                      } else {
                        search(searchcontroller.text);
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              searchcontroller.text.isEmpty
                  ? FutureBuilder<MovieRecommendationModel>(
                      future: popularmovie,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data?.results;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Top Search",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 20),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: data!.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailMovieScreen(
                                                      movieid: data[index].id,
                                                    )));
                                      },
                                      child: Container(
                                        height: 120,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Row(
                                          children: [
                                            Image.network(
                                              '$imageUrl${data[index].posterPath}',
                                              fit: BoxFit.fitHeight,
                                            ),
                                            SizedBox(width: 15),
                                            Text(
                                              data[index].title,
                                              maxLines: 2,
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )
                  : seachmovies == null
                      ? SizedBox.shrink()
                      : GridView.builder(
                          // scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: seachmovies?.results.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 15,
                                  // mainAxisExtent: 200,
                                  childAspectRatio: 1.2 / 2),
                          itemBuilder: (context, index) {
                            // ignore: unnecessary_null_comparison
                            return seachmovies!.results[index].backdropPath ==
                                    null
                                ? Column(
                                    children: [
                                      Image.asset(
                                        "assets/netflix.png",
                                        height: 170,
                                      ),
                                      Text(
                                        seachmovies!.results[index].title,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      )
                                    ],
                                  )
                                : Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailMovieScreen(
                                                          movieid: seachmovies!
                                                              .results[index]
                                                              .id)));
                                        },
                                        // child: Image.network(
                                        //   '${imageUrl}${seachmovies!.results[index].backdropPath}',
                                        //   height: 150,
                                        // )
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              '$imageUrl${seachmovies!.results[index].backdropPath}',
                                          height: 150,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          // textAlign: TextAlign.center,
                                          seachmovies!.results[index].title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                          },
                        )
            ],
          ),
        ),
      )),
    );
  }
}
