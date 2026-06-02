import 'package:equatable/equatable.dart';

abstract class UserDetailEvent extends Equatable {
  const UserDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadUserDetailEvent
    extends UserDetailEvent {
  final String username;

  const LoadUserDetailEvent(
      this.username,
      );

  @override
  List<Object?> get props => [username];
}