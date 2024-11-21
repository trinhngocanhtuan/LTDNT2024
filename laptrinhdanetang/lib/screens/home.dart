import 'package:flutter/material.dart';

import 'login_screen.dart'; // Đảm bảo file login_screen.dart tồn tại.
import 'register_screen.dart'; // Đảm bảo file register_screen.dart tồn tại.

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đăng nhập / Đăng ký"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/user.png'), // Đảm bảo ảnh tồn tại tại thư mục assets.
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: const Center(
                child: Text(
                  "Đăng nhập/Đăng ký?",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Trang chủ"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("Giới thiệu"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.event),
              title: const Text("Tin tức - Sự kiện"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text("Danh sách CV"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.post_add),
              title: const Text("Bài đăng tuyển"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.business),
              title: const Text("Danh sách DN"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Quản lý cá nhân"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Đăng xuất"),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCard(
              context,
              "Xin chào...",
              "Kết nối sinh viên tới doanh nghiệp",
              Colors.red,
                  () {},
            ),
            const SizedBox(height: 16),
            _buildCard(
              context,
              "Nếu bạn là Sinh viên...",
              "Nhấn vào đây",
              Colors.yellow,
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterScreen(type: "Sinh viên"),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildCard(
              context,
              "Nếu bạn là Doanh Nghiệp...",
              "Nhấn vào đây",
              Colors.blue,
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterScreen(type: "Doanh nghiệp"),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: const Text("Đăng nhập"),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: const Text("Liên hệ"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
      BuildContext context,
      String title,
      String subtitle,
      Color color,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(color: Colors.white70),
          ),
        ),
      ),
    );
  }
}
