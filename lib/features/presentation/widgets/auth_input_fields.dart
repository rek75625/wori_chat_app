import 'package:flutter/material.dart';
import 'package:whatsapp_clone_py/constants/app_sizing.dart';

class AuthInputFields extends StatelessWidget {
  final  String hint;
  final IconData icon;
  final  TextEditingController controller;
  final bool isPassword;
  const AuthInputFields({super.key, required this.hint, required this.icon, required this.controller,  this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Icon(icon),
            AppSizes.height8,
            Expanded(
              child: TextFormField(
                controller: controller,
                obscureText: isPassword,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}