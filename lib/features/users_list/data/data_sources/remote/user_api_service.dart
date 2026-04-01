import 'package:dio/dio.dart';
import 'package:aviara/core/constants/constants.dart';
import 'package:aviara/features/users_list/data/models/user_model.dart';

class UserApiService {
  final Dio _dio;

  UserApiService(this._dio) {
    _dio.options.headers = {
      "Accept": "application/json",
      "User-Agent": "Flutter-App",
    };
  }

  Future<List<UserModel>> getUsers() async {
    final response = await _dio.get("$usersAPIBaseURL/users");

    print(response.statusCode);
    print(response.data);

    final List data = response.data;

    return data.map((json) => UserModel.fromJson(json)).toList();
  }
}
