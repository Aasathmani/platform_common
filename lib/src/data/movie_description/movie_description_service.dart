import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:platform_common/src/core/exceptions.dart';
import 'package:platform_common/src/utils/extensions.dart';

class MovieDescriptionService {
  Future<List<Map<String, dynamic>>> fetchMovieDescription(
      String movieId) async {
    List<Map<String, dynamic>>? responseData = [];

    try {
      final url =
          "https://api.themoviedb.org/3/movie/$movieId?api_key=1d95bbff7686522ff196a517230f8855";
      final response = await http.get(
        Uri.parse(url),
      );
      responseData = [jsonDecode(response.body) as Map<String,dynamic>] ;
      if (response.statusCode == 200) {
        return responseData;
      } else {
        throw APIFailedException(
          message: toString(responseData[0]['message']),
        );
      }
    } catch (e) {
      throw CustomException(
        'Failed to fetch movie description',
        message: e.toString(),
      );
    }
  }
}
