import 'package:flutter/material.dart';
import 'package:new_strucuture/core/utils/app_colors.dart';

import '../../../config/routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondPrimary,
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.mainRoute);
            },
            child: const Text('Nav To Main Screen')),
      ),
    );
  }
}
