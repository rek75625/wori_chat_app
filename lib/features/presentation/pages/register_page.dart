import 'package:flutter/material.dart';
import 'package:whatsapp_clone_py/constants/app_sizing.dart';
import 'package:whatsapp_clone_py/features/presentation/pages/login_page.dart';
import 'package:whatsapp_clone_py/features/presentation/widgets/auth_input_fields.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
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
              AuthInputFields(hint: "Username",icon: Icons.person, controller: _usernameController),
              AppSizes.height24,
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
              
            },text: "Register",),
              AppSizes.height24,
              LoginPrompt(onTap: () {
                
              },text: "Login")
            ],
          ),
        ),
      ),
    );
  }



  
}
