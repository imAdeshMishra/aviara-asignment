import 'package:aviara/features/users_list/data/data_sources/local/user_local_data_source.dart';
import 'package:aviara/features/users_list/data/models/user_model.dart';
import 'package:aviara/features/users_list/domain/entities/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_users.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsersUseCase _getUsersUseCase;

  List<UserEntity> _allUsers = [];
  List<UserEntity> _visibleUsers = [];

  final int _limit = 5;

  final UserLocalDataSource _localDataSource;

  UserBloc(this._getUsersUseCase, this._localDataSource)
    : super(UserLoading()) {
    on<GetUsersEvent>(_onGetUsers);
    on<LoadMoreUsersEvent>(_onLoadMore);
  }

  void _onGetUsers(GetUsersEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());

    final dataState = await _getUsersUseCase();

    if (dataState.data != null) {
      final users = dataState.data!;

      _allUsers = users;
      _visibleUsers = [];

      if (_allUsers.isEmpty) {
        emit(UserEmpty());
        return;
      }

      await _localDataSource.cacheUsers(
        users
            .map(
              (e) => UserModel(
                id: e.id,
                name: e.name,
                username: e.username,
                email: e.email,
                address: e.address,
                phone: e.phone,
                website: e.website,
                company: e.company,
              ),
            )
            .toList(),
      );

      _visibleUsers = _allUsers.take(_limit).toList();

      emit(
        UserLoaded(
          _visibleUsers,
          hasMore: _visibleUsers.length < _allUsers.length,
          isFromCache: false,
        ),
      );
    } else {
      final cachedUsers = await _localDataSource.getCachedUsers();

      if (cachedUsers != null && cachedUsers.isNotEmpty) {
        _allUsers = cachedUsers;
        _visibleUsers = _allUsers.take(_limit).toList();

        emit(
          UserLoaded(
            _visibleUsers,
            hasMore: _visibleUsers.length < _allUsers.length,
            isFromCache: true,
          ),
        );
      } else {
        emit(UserError("No internet & no cached data available"));
      }
    }
  }

  void _onLoadMore(LoadMoreUsersEvent event, Emitter<UserState> emit) {
    if (state is! UserLoaded) return;

    if (_visibleUsers.length >= _allUsers.length) return;

    final start = _visibleUsers.length;
    final end = start + _limit;

    final nextUsers = _allUsers.sublist(
      start,
      end > _allUsers.length ? _allUsers.length : end,
    );

    _visibleUsers = [..._visibleUsers, ...nextUsers];

    emit(
      UserLoaded(
        _visibleUsers,
        hasMore: _visibleUsers.length < _allUsers.length,
      ),
    );
  }
}
