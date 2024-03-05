import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:netflixclone/module/searchModel.dart';

const String baseUrl = "https://api.themoviedb.org/3/";
const String apiKey = "5ce0f158fb62600150398db6bf5f6130";

Future<SearchModel> getSearchMovie(String searchText) async {
  try {
    final endpoint = 'search/movie';
    final url = '$baseUrl$endpoint?query=$searchText&api_key=$apiKey';

    print('Request URL: $url'); // Log the request URL

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print('Success: searching for $searchText');
      return SearchModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
          'Failed to search for movies with query: $searchText. Status Code: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception occurred: $e');
    throw Exception(
        'Failed to search for movies with query: $searchText. Error: $e');
  }
}
