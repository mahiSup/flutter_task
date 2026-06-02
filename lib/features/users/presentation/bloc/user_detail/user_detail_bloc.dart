import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_user_details.dart';
import 'user_detail_event.dart';
import 'user_detail_state.dart';

class UserDetailBloc
    extends Bloc<UserDetailEvent,
        UserDetailState> {
  final GetUserDetails getUserDetails;

  UserDetailBloc({
    required this.getUserDetails,
  }) : super(UserDetailInitial()) {
    on<LoadUserDetailEvent>(
      _loadUserDetail,
    );
  }

  Future<void> _loadUserDetail(
      LoadUserDetailEvent event,
      Emitter<UserDetailState> emit,
      ) async {
    emit(UserDetailLoading());

    final result =
    await getUserDetails(
      event.username,
    );

    result.fold(
          (failure) => emit(
        UserDetailError(
          failure.message,
        ),
      ),
          (user) => emit(
        UserDetailLoaded(user),
      ),
    );
  }
}