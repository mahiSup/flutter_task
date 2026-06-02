import 'package:flutter_bloc/flutter_bloc.dart';



import '../../../domain/usecases/get_users.dart';
import 'users_event.dart';
import 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetUsers getUsers;

  UsersBloc({
    required this.getUsers,
  }) : super(UsersInitial()) {
    on<LoadUsersEvent>(_loadUsers);
    on<RefreshUsersEvent>(_refreshUsers);
  }

  Future<void> _loadUsers(
      LoadUsersEvent event,
      Emitter<UsersState> emit,
      ) async {
    emit(UsersLoading());

    final result = await getUsers();

    result.fold(
          (failure) => emit(
        UsersError(failure.message),
      ),
          (users) {
        if (users.isEmpty) {
          emit(UsersEmpty());
        } else {
          emit(
            UsersLoaded(users),
          );
        }
      },
    );
  }

  Future<void> _refreshUsers(
      RefreshUsersEvent event,
      Emitter<UsersState> emit,
      ) async {
    add(const LoadUsersEvent());
  }
}