import 'package:flutter/material.dart';
import 'package:whatsapp_clone_py/constants/app_sizing.dart';
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
              AuthInputFields(hint:"Email",icon: Icons.person,controller: _emailController),
              AppSizes.height24,
              AuthInputFields(hint:
                "Password",icon:
                Icons.person,controller: 
                _passwordController,
                isPassword: true,
              ),
              AppSizes.height24,
            AuthButton(onPressed: () {
              
            },text: "Login",),
              AppSizes.height24,
              AuthPrompt(onTap: () {
                
              },text: "Register")
            ],
          ),
        ),
      ),
    );
  }

 

}


