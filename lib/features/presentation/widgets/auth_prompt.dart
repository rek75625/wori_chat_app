import 'package:flutter/material.dart';

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
