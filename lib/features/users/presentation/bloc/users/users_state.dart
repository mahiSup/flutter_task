import 'package:equatable/equatable.dart';

import '../../../domain/entities/github_user.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object?> get props => [];
}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final List<GithubUser> users;

  const UsersLoaded(this.users);

  @override
  List<Object?> get props => [users];
}

class UsersEmpty extends UsersState {}

class UsersError extends UsersState {
  final String message;

  const UsersError(this.message);

  @override
  List<Object?> get props => [message];
}