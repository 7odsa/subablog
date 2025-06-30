import 'package:subablog/core/error/exeptions.dart';
import 'package:subablog/features/auth/data/models/user_dm.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDs {
  Session? get currentUserSession;

  Future<UserDm> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserDm> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<UserDm?> getCurrentUserData();
}

class AuthRemoteDsImpl implements AuthRemoteDs {
  final SupabaseClient supabaseClient;

  AuthRemoteDsImpl({required this.supabaseClient});

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserDm> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );

      if (response.user == null) {
        throw ServerExeption('User Is Null!');
      }

      return UserDm.fromJson(
        response.user!.toJson(),
      ).copyWith(email: currentUserSession!.user.email);
    } catch (e) {
      throw ServerExeption(e.toString());
    }
  }

  @override
  Future<UserDm> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );

      if (response.user == null) {
        throw ServerExeption('User Is Null!');
      }

      return UserDm.fromJson(
        response.user!.toJson(),
      ).copyWith(email: currentUserSession!.user.email);
    } catch (e) {
      throw ServerExeption(e.toString());
    }
  }

  @override
  Future<UserDm?> getCurrentUserData() async {
    try {
      UserDm? user;
      if (currentUserSession != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', currentUserSession!.user.id);
        user = UserDm.fromJson(
          userData.first,
        ).copyWith(email: currentUserSession!.user.email);
      }
      return user;
    } catch (e) {
      throw ServerExeption(e.toString());
    }
  }
}
