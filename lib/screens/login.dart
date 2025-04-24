import 'package:btcn_ltdd/services/auth.dart';
import 'package:btcn_ltdd/services/storage.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final api = AuthService();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Đăng nhập - Manager')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('ĐĂNG NHẬP', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Tên đăng nhập'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Mật khẩu'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final email = _emailController.text.trim();
                final password = _passwordController.text;

                try {
                  final res = await api.login(email, password);
                  final token = res.data['token'];

                  // Lưu token
                  await Storage.saveToken(token);

                  // Navigate sang Home
                  Navigator.pushReplacementNamed(context, '/home');
                } catch (e) {
                  print("Đăng nhập thất bại: $e");

                  // Hiển thị dialog lỗi
                  if (context.mounted) {
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: const Text('Lỗi đăng nhập'),
                            content: Text(e.toString()),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Đóng'),
                              ),
                            ],
                          ),
                    );
                  }
                }
              },
              child: const Text('Đăng nhập'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    // Navigate đến màn hình đăng ký
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text('Đăng ký'),
                ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: () {
                    // Navigate đến màn hình quên mật khẩu
                    Navigator.pushNamed(context, '/forgot-password');
                  },
                  child: const Text('Quên mật khẩu?'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
