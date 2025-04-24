import 'package:btcn_ltdd/screens/verify.dart';
import 'package:btcn_ltdd/screens/verify_password.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/forgot_password.dart';
import 'screens/home.dart';
import 'widgets/auth_wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Team Manager App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const IntroPage(),
      routes: {
        '/login': (context) => const AuthWrapper(child: LoginScreen()),
        '/register': (context) => const AuthWrapper(child: RegisterScreen()),
        '/forgot-password':
            (context) => const AuthWrapper(child: ForgotPasswordScreen()),
        '/verify': (context) => const VerifyScreen(),
        '/verify-password': (context) => const VerifyPasswordScreen(),
        '/home': (context) => const AuthWrapper(child: HomeScreen()),
      },
    );
  }
}

// Trang 1: Giới thiệu nhóm
class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    super.initState();
    // Sau 10s thì chuyển sang trang Login
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Nhóm 18',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text('- Phạm Hùng Phong - 21110273'),
            const Text('- Nguyễn Anh Hào - 21110823'),
            const SizedBox(height: 30),
            const CircularProgressIndicator(),
            const SizedBox(height: 10),
            const Text(
              'Chuyển trang trong 10s',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
