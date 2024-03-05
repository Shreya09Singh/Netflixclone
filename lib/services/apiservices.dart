import 'dart:convert';
import 'dart:developer';

import 'package:netflixclone/common/utils.dart';
import 'package:netflixclone/module/detailTvseriesmodule.dart';
import 'package:netflixclone/module/detailmoviemodule.dart';
import 'package:netflixclone/module/moviemodule.dart';
import 'package:http/http.dart' as http;
import 'package:netflixclone/module/popularmoviemodel.dart';
import 'package:netflixclone/module/searchModel.dart';
import 'package:netflixclone/module/topratedTvmodule.dart';
import 'package:netflixclone/module/upcomingmodule.dart';

const baseUrl = 'https://api.themoviedb.org/3/';

var key = '?api_key=$apiKey';
late String endpoint;

class ApiServices {
  Future<MovieModel> getUpcomingMovie() async {
    endpoint = 'movie/upcoming';
    final url = '$baseUrl$endpoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log('success');
      return MovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load upcoming movies');
  }

  Future<MovieModel> getNowplayingmovie() async {
    endpoint = 'movie/now_playing';
    final url = '$baseUrl$endpoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log('success nowplaying');
      return MovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load nowplaying movies');
  }

  Future<TopRatedTv> getTopratedTv() async {
    endpoint = 'tv/top_rated';
    final url = '$baseUrl$endpoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log('success nowplaying');
      return TopRatedTv.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load top rated TvSeries');
  }

  Future<MovieRecommendationModel> getPopuparmovie() async {
    endpoint = 'movie/popular';
    final url = '$baseUrl$endpoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log('success popularshow');

      return MovieRecommendationModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load top popular for you!');
  }

  Future<DetailMovieModel> getMovieDetails(int movieid) async {
    endpoint = 'movie/${movieid}';
    final url = '$baseUrl$endpoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log('success movieDetails');
      log(url);
      return DetailMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load Movie Details');
  }

  Future<DetailTvSereisModule> getTvDetails(int series_id) async {
    endpoint = 'tv/${series_id}';
    final url = '$baseUrl$endpoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log('success tvdetails');
      log(url);
      return DetailTvSereisModule.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load tvseries Details');
  }

  Future<Comingsoon> getComingSoonmovie() async {
    endpoint = 'movie/upcoming';
    final url = '$baseUrl$endpoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log('success comingsoon');
      log(url);
      return Comingsoon.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load coming soon');
  }

  Future<MovieRecommendationModel> getMovieRecommendation(int movieid) async {
    endpoint = 'movie/${movieid}/recommendations';
    final url = '$baseUrl$endpoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log('success movierecomendations');
      log(url);
      return MovieRecommendationModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load Movie recommendations');
  }

  Future<SearchModel> getSearchMovie(searchtext) async {
    const String baseUrl = "https://api.themoviedb.org/3/";
    const String apiKey = "5ce0f158fb62600150398db6bf5f6130";
    final endpoint = 'search/movie';
    final url = '$baseUrl$endpoint?query=$searchtext&api_key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("search successful url");
      log(url);

      return SearchModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load top rated TvSeries');
  }
}
