import 'package:aviara/features/users_list/data/data_sources/local/user_local_data_source.dart';
import 'package:aviara/features/users_list/data/data_sources/remote/user_api_service.dart';
import 'package:aviara/features/users_list/data/repository/user_repository_impl.dart';
import 'package:aviara/features/users_list/domain/usecases/get_users.dart';
import 'package:dio/dio.dart';

final dio = Dio();

final apiService = UserApiService(dio);
final userLocalDataSource = UserLocalDataSource();

final userRepository = UserRepositoryImpl(apiService);

final getUsersUseCase = GetUsersUseCase(userRepository);
