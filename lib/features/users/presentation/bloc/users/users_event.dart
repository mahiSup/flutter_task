import 'package:equatable/equatable.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object?> get props => [];
}

class LoadUsersEvent extends UsersEvent {
  const LoadUsersEvent();
}

class RefreshUsersEvent extends UsersEvent {
  const RefreshUsersEvent();
}

class SearchUsersEvent extends UsersEvent {
  final String query;

  const SearchUsersEvent(this.query);

  @override
  List<Object?> get props => [query];
}