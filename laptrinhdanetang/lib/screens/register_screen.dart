import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  final String type;
  const RegisterScreen({Key? key, required this.type}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref(); // Tham chiếu Realtime Database

  int step = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(step == 0
            ? "${widget.type} - Nhập email"
            : "${widget.type} - Thay đổi mật khẩu"),
      ),
      body: step == 0 ? _buildEmailStep() : _buildPasswordStep(),
    );
  }

  Widget _buildEmailStep() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${widget.type} đang theo học\nVui lòng nhập mail nhà trường đã cấp cho bạn",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 16),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: "GMAIL",
              hintText: "example@vku.udn.vn",
            ),
          ),
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              final email = emailController.text.trim();
              if (_isValidVKUEmail(email)) {
                setState(() {
                  step = 1;
                });
              } else {
                _showErrorDialog("Vui lòng nhập email có đuôi @vku.udn.vn");
              }
            },
            child: Text("GỬI"),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordStep() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Bạn hãy thay đổi mật khẩu mới cho tài khoản của bạn",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 16),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: "Mật khẩu mới",
              suffixIcon: Icon(Icons.visibility),
            ),
            obscureText: true,
          ),
          SizedBox(height: 16),
          TextField(
            controller: confirmPasswordController,
            decoration: InputDecoration(
              labelText: "Nhập lại mật khẩu",
              suffixIcon: Icon(Icons.visibility),
            ),
            obscureText: true,
          ),
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: () async {
              final password = passwordController.text.trim();
              final confirmPassword = confirmPasswordController.text.trim();
              if (password.isEmpty || confirmPassword.isEmpty) {
                _showErrorDialog("Vui lòng nhập đầy đủ mật khẩu");
              } else if (password != confirmPassword) {
                _showErrorDialog("Mật khẩu không khớp");
              } else {
                await _saveToDatabase(emailController.text.trim(), password);
                _showSuccessDialog("Đăng ký thành công!");
              }
            },
            child: Text("GỬI"),
          ),
        ],
      ),
    );
  }

  bool _isValidVKUEmail(String email) {
    return email.endsWith("@vku.udn.vn");
  }

  Future<void> _saveToDatabase(String email, String password) async {
    try {
      await databaseRef.child("users").push().set({
        "email": email,
        "password": password,
        "type": widget.type,
        "timestamp": DateTime.now().toIso8601String(),
      });
    } catch (e) {
      _showErrorDialog("Lỗi khi lưu dữ liệu: $e");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Lỗi"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Đóng"),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Thành công"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Đóng dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              ); // Chuyển sang màn hình đăng nhập
            },
            child: Text("Đóng"),
          ),
        ],
      ),
    );
  }
}
