import 'package:flutter/material.dart';
import '../services/storage.dart';
import '../screens/login.dart';

const unprotectedRoutes = [
  '/login',
  '/register',
  '/forgot-password',
  '/verify',
];

class AuthWrapper extends StatelessWidget {
  final Widget child;

  const AuthWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '/';

    return FutureBuilder(
      future: Storage.getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final token = snapshot.data;

        final isProtected = !unprotectedRoutes.contains(currentRoute);

        // Nếu cần token nhưng không có thì chuyển sang login
        if (isProtected && (token == null || token.isEmpty)) {
          return const LoginScreen();
        }

        return child;
      },
    );
  }
}
