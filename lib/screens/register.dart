import 'package:btcn_ltdd/services/auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final api = AuthService();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _fullnameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Đăng ký - Manager')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('ĐĂNG KÝ', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            TextField(
              controller: _fullnameController,
              decoration: const InputDecoration(labelText: 'Họ và tên'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Tên đăng nhập'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Mật khẩu'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final fullname = _fullnameController.text.trim();
                final email = _emailController.text.trim();
                final password = _passwordController.text.trim();

                try {
                  // Gọi API đăng ký (có thể là một API đăng ký riêng biệt, thay vì login)
                  await api.register(
                    fullname: fullname,
                    email: email,
                    password: password,
                  );

                  // Sau khi đăng ký thành công, chuyển đến trang đăng nhập
                  Navigator.pushReplacementNamed(
                    context,
                    '/verify',
                    arguments: {'email': email},
                  );
                } catch (e) {
                  print("Đăng ký thất bại: $e");

                  // Hiển thị dialog lỗi
                  if (context.mounted) {
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: const Text('Lỗi đăng ký'),
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
              child: const Text('Đăng ký'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Đã có tài khoản? "),
                TextButton(
                  onPressed: () {
                    // Quay lại trang đăng nhập
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text('Đăng nhập'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
