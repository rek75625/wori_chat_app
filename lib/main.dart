import 'package:flutter/material.dart';
import 'package:whatsapp_clone_py/constants/theme.dart';
import 'package:whatsapp_clone_py/features/presentation/pages/single_chat_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
     
      home: SingleChatPage(),
    );
  }
}
