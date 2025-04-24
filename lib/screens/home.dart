import 'package:flutter/material.dart';
import 'package:btcn_ltdd/services/auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final api = AuthService();
    return Scaffold(
      appBar: AppBar(title: const Text('Trang chủ')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Căn giữa theo chiều dọc
            crossAxisAlignment:
                CrossAxisAlignment.center, // Căn giữa theo chiều ngang
            children: [
              const Text(
                'TRANG CHỦ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await api.logout();

                    if (context.mounted) {
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                  } catch (e) {
                    print("Đăng xuất thất bại");

                    if (context.mounted) {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: const Text('Lỗi đăng xuất'),
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
                child: const Text('Đăng xuất'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
