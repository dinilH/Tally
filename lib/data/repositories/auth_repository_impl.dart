import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import '../../domain/models/user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._client);

  final sb.SupabaseClient _client;

  AppUser _map(sb.User u) => AppUser(
    id: u.id,
    name: (u.userMetadata?['name'] as String?) ?? 'User',
    email: u.email,
  );

  @override
  AppUser? get currentUser {
    final u = _client.auth.currentUser;
    return u == null ? null : _map(u);
  }

  @override
  Stream<AppUser?> authStateChanges() => _client.auth.onAuthStateChange
      .map((s) => s.session?.user == null ? null : _map(s.session!.user));

  @override
  Future<AppUser> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final res = await _client.auth.signUp(
      email: email,
      password: password,
      data: {'name': name},
    );
    final user = res.user;
    if (user == null) throw Exception('Sign up failed');
    return _map(user);
  }

  @override
  Future<AppUser> signIn({
    required String email,
    required String password,
  }) async {
    final res = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final user = res.user;
    if (user == null) throw Exception('Sign in failed');
    return _map(user);
  }

  @override
  Future<void> signOut() => _client.auth.signOut();
}