import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pot_g/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:pot_g/app/modules/user/domain/entities/user_entity.dart';

part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc(this._repository) : super(const AuthState.initial()) {
    on<_Load>(_onLoad);
    on<_Login>(_onLogin);
    on<_Logout>(_onLogout);
  }

  Future<void> _onLoad(AuthEvent event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    return emit.forEach(
      _repository.user,
      onData: (user) {
        if (user != null) {
          return AuthState.authenticated(user);
        } else {
          return const AuthState.unauthenticated();
        }
      },
    );
  }

  Future<void> _onLogin(AuthEvent event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final user = await _repository.signIn();
      emit(AuthState.authenticated(user));
    } catch (e) {
      emit(AuthState.error(e.toString()));
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> _onLogout(AuthEvent event, Emitter<AuthState> emit) async {
    emit(const AuthState.unauthenticated());
    await _repository.signOut();
  }
}

@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.load() = _Load;
  const factory AuthEvent.login() = _Login;
  const factory AuthEvent.logout() = _Logout;
}

@freezed
sealed class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.unauthenticated() = Unauthenticated;
  const factory AuthState.authenticated(UserEntity user) = Authenticated;
  const factory AuthState.error(String message) = AuthError;

  UserEntity? get user => switch (this) {
    Authenticated(:final user) => user,
    _ => null,
  };
}
