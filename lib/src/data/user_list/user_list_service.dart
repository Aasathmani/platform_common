import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:platform_common/src/core/exceptions.dart';
import 'package:platform_common/src/utils/extensions.dart';

class UserListService {
  Future<Map<String, dynamic>> fetchUserList(int page) async {
    Map<String, dynamic> responseData = {};

    try {
      final url = "https://reqres.in/api/users?page={$page}";
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
  }

  Future<bool> fetchCreateUser(
    Map<String, dynamic> data,
  ) async {
    try {
      const url = "https://reqres.in/api/users";
      final body = jsonEncode(data);
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else if (response.statusCode == 400) {
        throw APIFailedException(
          message: toString("Failed to create"),
        );
      }
    } catch (e) {
      if (e is APIFailedException) {
        rethrow;
      }
      throw CustomException(
        'Create user Failed.',
        message: e.toString(),
      );
    }
    return false;
  }
}
