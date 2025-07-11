import 'package:get_it/get_it.dart';
import 'package:subablog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:subablog/core/secrets/app_secrets.dart';
import 'package:subablog/features/auth/data/data_sources/auth_remote_ds.dart';
import 'package:subablog/features/auth/data/repos/auth_repo_impl.dart';
import 'package:subablog/features/auth/domain/repos/auth_repo.dart';
import 'package:subablog/features/auth/domain/usecases/current_user_usecase.dart';
import 'package:subablog/features/auth/domain/usecases/login_usecase.dart';
import 'package:subablog/features/auth/domain/usecases/signup_usecase.dart';
import 'package:subablog/features/auth/ui/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> initDependancies() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseApiKey,
  );

  _initAuth();
  sl.registerLazySingleton<SupabaseClient>(() => supabase.client);
}

void _initAuth() {
  sl
    ..registerLazySingleton<AuthRemoteDs>(
      () => AuthRemoteDsImpl(supabaseClient: sl()),
    )
    ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(authRemoteDs: sl()))
    ..registerLazySingleton<SignupUsecase>(() => SignupUsecase(authRepo: sl()))
    ..registerLazySingleton<LoginUsecase>(() => LoginUsecase(authRepo: sl()))
    ..registerLazySingleton<CurrentUserUsecase>(
      () => CurrentUserUsecase(authRepo: sl()),
    )
    ..registerLazySingleton<AppUserCubit>(() => AppUserCubit())
    ..registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        appUserCubit: sl(),
        signupUsecase: sl(),
        loginUsecase: sl(),
        currUserUsecase: sl(),
      ),
    );
}
