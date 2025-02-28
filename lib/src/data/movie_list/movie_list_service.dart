import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:platform_common/src/core/exceptions.dart';
import 'package:platform_common/src/utils/extensions.dart';

class MovieListService {
  Future<Map<String, dynamic>> fetchMovieList(int page) async {
    Map<String, dynamic> responseData = {};

    try {
      final url =
          "https://api.themoviedb.org/3/trending/movie/day?language=en-US&page=$page&api_key=1d95bbff7686522ff196a517230f8855";
      final response = await http.get(
        Uri.parse(url),
      );
      responseData = toGenericMap(jsonDecode(response.body));
      if (response.statusCode == 200) {
        return responseData;
      } else {
        throw APIFailedException(
          message: toString(responseData['message']),
        );
      }
    } catch (e) {
      throw CustomException(
        'Failed to fetch user list',
        message: e.toString(),
      );
    }
  }
}
