import 'package:flutter/material.dart';
import 'package:whatsapp_clone_py/constants/app_sizing.dart';
import 'package:whatsapp_clone_py/constants/colors.dart';

class AuthButton extends StatelessWidget {
   final VoidCallback onPressed;
  final String text;
  const AuthButton({
    super.key, required this.onPressed, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: DefaultColors.buttonColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
          child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
        );
  }
}


class AuthPrompt extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const AuthPrompt({
    super.key, required this.onTap, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
          child: GestureDetector(
            onTap: onTap,
            child: RichText(
              text: TextSpan(
                text: "Already have an account? ",
                style: TextStyle(color: Colors.grey),
                children: [
    TextSpan(
      text: text,
      style: TextStyle(color: Colors.blue),
    ),
                ],
              ),
            ),
          ),
        );
  }
}


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
