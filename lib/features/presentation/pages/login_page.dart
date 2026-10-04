import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_py/constants/app_sizing.dart';
import 'package:whatsapp_clone_py/features/presentation/bloc/auth_bloc.dart';
import 'package:whatsapp_clone_py/features/presentation/bloc/auth_event.dart';
import 'package:whatsapp_clone_py/features/presentation/bloc/auth_state.dart';
import 'package:whatsapp_clone_py/features/presentation/widgets/auth_button.dart';
import 'package:whatsapp_clone_py/features/presentation/widgets/auth_input_fields.dart';
import 'package:whatsapp_clone_py/features/presentation/widgets/auth_prompt.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    BlocProvider.of<AuthBloc>(context).add(
      LoginEvent(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: AppSizes.padAll24,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthInputFields(
                hint: "Email",
                icon: Icons.person,
                controller: _emailController,
              ),
              AppSizes.height24,
              AuthInputFields(
                hint: "Password",
                icon: Icons.person,
                controller: _passwordController,
                isPassword: true,
              ),
              BlocConsumer<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return AuthButton(onPressed: _login, text: "Login");
                },
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      "/conversationsPage",
                      (route) => false,
                    );
                  } else if (state is AuthFailure) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.error)));
                  }
                },
              ),

              AppSizes.height24,
              AuthPrompt(
                onTap: () {
                  Navigator.pushNamed(context, "/login");
                },
                text: "Register",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
