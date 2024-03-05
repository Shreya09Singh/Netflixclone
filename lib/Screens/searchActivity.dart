import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:netflixclone/services/apiservices.dart';
import 'package:netflixclone/module/searchModel.dart';
import 'package:netflixclone/module/popularmoviemodel.dart';
import 'package:netflixclone/common/utils.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ApiServices apiService = ApiServices();
  final TextEditingController searchController = TextEditingController();
  SearchModel? searchMovies;
  late Future<MovieRecommendationModel> popularmovie;

  void search(String query) {
    apiService.getSearchMovie(query).then((value) {
      setState(() {
        searchMovies = value;
      });
    });
  }

  @override
  void initState() {
    popularmovie = apiService.getPopuparmovie();
    super.initState();
  }

  void clear() {
    searchController.clear();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 55,
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            clear();
                          });
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.grey,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      hintText: 'search',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    style: TextStyle(fontSize: 19),
                    onChanged: (value) {
                      if (value.isEmpty) {
                      } else {
                        search(searchController.text);
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              searchController.text.isEmpty
                  ? FutureBuilder<MovieRecommendationModel>(
                      future: popularmovie,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data!.results;
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
                                itemCount: data.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
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
                                  );
                                },
                              ),
                            ],
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    )
                  : searchMovies == null
                      ? SizedBox.shrink()
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 20,
                                  mainAxisExtent: 150,
                                  childAspectRatio: 1.2 / 2),
                          itemCount: searchMovies!.results.length,
                          itemBuilder: (context, index) {
                            return Column(
                              // crossAxisAlignment:
                              //     CrossAxisAlignment.start,
                              children: [
                                searchMovies!
                                            .results[index]
                                            // ignore: unnecessary_null_comparison
                                            .backdropPath ==
                                        null
                                    ? Image.asset(
                                        'assets/netflix.png',
                                        height: 140,
                                      )
                                    : CachedNetworkImage(
                                        imageUrl:
                                            '$imageUrl${searchMovies!.results[index].backdropPath}',
                                        height: 140,
                                      ),
                                Text(
                                  searchMovies!.results[index].originalTitle,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            );
                          },
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
