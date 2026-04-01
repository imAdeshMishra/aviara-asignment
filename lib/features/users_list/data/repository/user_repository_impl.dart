import 'package:dio/dio.dart';
import 'package:aviara/core/resources/data_state.dart';
import 'package:aviara/features/users_list/data/data_sources/remote/user_api_service.dart';
import 'package:aviara/features/users_list/domain/entities/user.dart';
import 'package:aviara/features/users_list/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserApiService _userApiService;

  UserRepositoryImpl(this._userApiService);

  @override
  Future<DataState<List<UserEntity>>> getUsers() async {
    try {
      final users = await _userApiService.getUsers();

      return DataSuccess(users);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
