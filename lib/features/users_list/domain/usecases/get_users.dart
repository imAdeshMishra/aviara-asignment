import 'package:aviara/core/resources/data_state.dart';
import 'package:aviara/features/users_list/domain/entities/user.dart';
import 'package:aviara/features/users_list/domain/repository/user_repository.dart';

class GetUsersUseCase {
  final UserRepository _userRepository;

  GetUsersUseCase(this._userRepository);

  Future<DataState<List<UserEntity>>> call() async {
    return await _userRepository.getUsers();
  }
}
