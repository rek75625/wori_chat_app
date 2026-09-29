import 'package:flutter/material.dart';
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
