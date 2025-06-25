import 'package:subablog/core/error/exeptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDs {
  Future<String> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<String> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDsImpl implements AuthRemoteDs {
  final SupabaseClient supabaseClient;

  AuthRemoteDsImpl({required this.supabaseClient});

  @override
  Future<String> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    supabaseClient.auth.signInWithPassword(password: password, email: email);
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailAndPassword({
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

      return response.user!.id;
    } catch (e) {
      throw ServerExeption(e.toString());
    }
  }
}
