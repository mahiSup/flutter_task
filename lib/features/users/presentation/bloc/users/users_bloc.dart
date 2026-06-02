import 'package:flutter_bloc/flutter_bloc.dart';



import '../../../../../core/utils/debounce.dart';
import '../../../domain/usecases/get_users.dart';
import '../../../domain/usecases/search_users.dart';
import 'users_event.dart';
import 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetUsers getUsers;
  final SearchUsers searchUsers;

  UsersBloc({
    required this.getUsers,
    required this.searchUsers,
  }) : super(UsersInitial()) {
    on<LoadUsersEvent>(_loadUsers);
    on<RefreshUsersEvent>(_refreshUsers);
    on<SearchUsersEvent>(
      _searchUsers,
      transformer: debounce(
        const Duration(
          milliseconds: 500,
        ),
      ),
    );
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

  Future<void> _searchUsers(
      SearchUsersEvent event,
      Emitter<UsersState> emit,
      ) async {

    if(event.query.isEmpty){
      add(const LoadUsersEvent());
      return;
    }

    emit(UsersLoading());

    final result =
    await searchUsers(
      event.query,
    );

    result.fold(
          (failure) =>
          emit(
            UsersError(
              failure.message,
            ),
          ),
          (users) =>
          emit(
            UsersLoaded(
              users,
            ),
          ),
    );
  }
}