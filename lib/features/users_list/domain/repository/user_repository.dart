import 'package:aviara/core/resources/data_state.dart';
import 'package:aviara/features/users_list/domain/entities/user.dart';

abstract class UserRepository {
  Future<DataState<List<UserEntity>>> getUsers();
}
