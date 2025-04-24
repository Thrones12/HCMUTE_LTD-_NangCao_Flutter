import 'package:flutter/material.dart';
import 'package:btcn_ltdd/services/auth.dart';

class VerifyPasswordScreen extends StatefulWidget {
  const VerifyPasswordScreen({super.key});

  @override
  _VerifyPasswordScreenState createState() => _VerifyPasswordScreenState();
}

class _VerifyPasswordScreenState extends State<VerifyPasswordScreen> {
  final _otpController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    final api = AuthService();
    // Lấy dữ liệu được truyền từ trang trước
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final email = args?['email'] ?? 'Không email';

    return Scaffold(
      appBar: AppBar(title: const Text('Xác thực OTP')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Nhập mã OTP đã gửi đến email',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Mã OTP'),
            ),
            const SizedBox(height: 20),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                  onPressed: () async {
                    final otp = _otpController.text.trim();

                    if (otp.isEmpty) {
                      setState(() {
                        _errorMessage = 'Vui lòng nhập mã OTP';
                      });
                      return;
                    }

                    setState(() {
                      _isLoading = true;
                    });

                    try {
                      // Gọi API xác thực OTP
                      final res = await api.verifyOtp(email, otp);
                      if (res == true) {
                        await api.regeneratePassword(email: email);
                        // Điều hướng đến trang Home sau khi xác thực thành công
                        Navigator.pushReplacementNamed(context, '/login');
                      } else {
                        // Hiển thị dialog lỗi
                        if (context.mounted) {
                          showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: const Text('Tthất bại'),
                                  content: Text("Xác thực OTP thất bại"),
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
                    } catch (e) {
                      setState(() {
                        _errorMessage = 'Xác thực OTP thất bại: $e';
                      });
                    } finally {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
                  child: const Text('Xác thực'),
                ),
          ],
        ),
      ),
    );
  }
}
