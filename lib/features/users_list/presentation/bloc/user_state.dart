import '../../domain/entities/user.dart';

abstract class UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<UserEntity> users;
  final bool hasMore;
  final bool isFromCache;

  UserLoaded(this.users, {this.hasMore = true, this.isFromCache = false});
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}

class UserEmpty extends UserState {}
