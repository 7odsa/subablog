import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subablog/core/common/widgets/loader.dart';
import 'package:subablog/core/theme/app_colors.dart';
import 'package:subablog/core/utils/show_snackbar.dart';
import 'package:subablog/features/auth/ui/bloc/auth_bloc.dart';
import 'package:subablog/features/auth/ui/pages/signup_screen.dart';
import 'package:subablog/features/auth/ui/widgets/auth_button.dart';
import 'package:subablog/features/auth/ui/widgets/auth_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static route() => MaterialPageRoute(builder: (context) => LoginScreen());

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackbar(context, state.msg);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) return Loader();

            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Sign In.",
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 32),
                  AuthField(hintText: 'Email', controller: emailController),
                  SizedBox(height: 16),
                  AuthField(
                    hintText: 'Password',
                    controller: passwordController,
                    isPassword: true,
                  ),
                  SizedBox(height: 22),
                  AuthButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          AuthLogin(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          ),
                        );
                      }
                    },
                    text: 'Sign In',
                  ),
                  SizedBox(height: 22),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      SignupScreen.route(),
                    ),
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t have an Account?  ',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: AppColors.gradient2,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
