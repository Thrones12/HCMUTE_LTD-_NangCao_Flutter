import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

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
      home: IntroPage(),
      routes: {'/login': (context) => LoginPage()},
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
    Timer(Duration(seconds: 10), () {
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
            Text(
              'Nhóm 18',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('- Phạm Hùng Phong - 21110273'),
            Text('- Nguyễn Anh Hào - 21110823'),
            SizedBox(height: 30),
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text(
              'Chuyển trang trong 10s',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}

// Trang 2: Login dành cho Manager
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Đăng nhập - Manager')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ĐĂNG NHẬP', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            TextField(decoration: InputDecoration(labelText: 'Tên đăng nhập')),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Mật khẩu'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print("Đăng nhập nè");
              },
              child: Text('Đăng nhập'),
            ),
          ],
        ),
      ),
    );
  }
}
