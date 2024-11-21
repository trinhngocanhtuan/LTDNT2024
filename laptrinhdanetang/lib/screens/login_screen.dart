import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'user_profile_screen.dart'; // Import màn hình UserProfileScreen

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    String email = _emailController.text.trim(); // Lấy Gmail từ ô nhập liệu
    String password = _passwordController.text.trim(); // Lấy mật khẩu từ ô nhập liệu

    try {
      // Truy xuất dữ liệu từ Firebase
      final snapshot = await _databaseRef.child('sinhvien/khoa/2021/lop/21SE3').get();

      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        bool isAuthenticated = false;
        String userId = ""; // Biến lưu mã số sinh viên hoặc ID

        // Kiểm tra thông tin đăng nhập
        data.forEach((key, value) {
          if (value['Gmail'] == email && value['MatKhau'] == password) {
            isAuthenticated = true;
            userId = key; // Lưu mã số sinh viên hoặc ID
          }
        });

        if (isAuthenticated) {
          // Đăng nhập thành công -> Chuyển đến UserProfileScreen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Đăng nhập thành công!")),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UserProfileScreen(userId: userId), // Chuyển đến UserProfileScreen
            ),
          );
        } else {
          // Sai thông tin đăng nhập
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Sai Gmail hoặc mật khẩu!")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Không tìm thấy thông tin sinh viên!")),
        );
      }
    } catch (e) {
      print("Lỗi: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Đã xảy ra lỗi: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đăng nhập"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Gmail"),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: "Mật khẩu"),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _login,
              child: const Text("Đăng nhập"),
            ),
          ],
        ),
      ),
    );
  }
}
