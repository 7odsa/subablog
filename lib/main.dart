import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subablog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:subablog/core/theme/theme.dart';
import 'package:subablog/di/di.dart';
import 'package:subablog/features/auth/ui/bloc/auth_bloc.dart';
import 'package:subablog/features/auth/ui/pages/login_screen.dart';
import 'package:subablog/features/blog/presenation/pages/blog_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependancies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AppUserCubit>()),
        BlocProvider(create: (context) => sl<AuthBloc>()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedin());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return (state is AppUserLoggedIn);
        },
        builder: (context, state) {
          if (state) {
            return BlogPage();
          }
          return LoginScreen();
        },
      ),
    );
  }
}
