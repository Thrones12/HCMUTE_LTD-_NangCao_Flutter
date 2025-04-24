import 'package:btcn_ltdd/services/auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final api = AuthService();
    final _emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text('Quên mật khẩu - Manager')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('QUÊN MẬT KHẨU', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final email = _emailController.text.trim();

                try {
                  await api.lock(email: email);

                  Navigator.pushReplacementNamed(
                    context,
                    '/verify-password',
                    arguments: {'email': email},
                  );
                } catch (e) {}
              },
              child: Text('Đăng nhập'),
            ),
          ],
        ),
      ),
    );
  }
}
