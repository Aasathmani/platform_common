import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:platform_common/src/core/exceptions.dart';
import 'package:platform_common/src/utils/extensions.dart';

class UserListService {
  Future<Map<String, dynamic>> fetchUserList() async {
    Map<String, dynamic> responseData = {};

    try {
      const url = "https://reqres.in/api/users?page={1}";
      final http.Response response = await http.get(Uri.parse(url));
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
    return responseData;
  }
}
