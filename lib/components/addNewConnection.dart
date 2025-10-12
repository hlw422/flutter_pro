import 'package:flutter/material.dart';

class AddNewConnection extends StatefulWidget {
  const AddNewConnection({super.key});

  @override
  AddNewConnectionState createState() => AddNewConnectionState();
}

class AddNewConnectionState extends State<AddNewConnection> {
  // 在State类中添加一个布尔值控制密码可见性
  bool _isPasswordVisible = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _hostController = TextEditingController();
  final TextEditingController _portController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Widget build(BuildContext context) {
    // 确保有Scaffold作为根组件
    return Scaffold(
      appBar: AppBar(title: const Text('添加新连接')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '连接名称',
                border: OutlineInputBorder(),
                helperText: "例如：公司内网",
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _hostController,
              decoration: const InputDecoration(
                labelText: '主机地址',
                border: OutlineInputBorder(),
                helperText: "例如：192.168.1.100",
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _portController,
              decoration: const InputDecoration(
                labelText: '端口号',
                border: OutlineInputBorder(),
                helperText: "例如：6379",
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible, // 控制密码显示/隐藏
              decoration: InputDecoration(
                labelText: '密码 (可选)',
                border: OutlineInputBorder(),
                // 可选：添加显示/隐藏密码的切换按钮
                // 点击图标切换密码可见性
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.centerRight, // 靠右对齐
              child: ElevatedButton(
                onPressed: () {
                  onPressed();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text('测试连接'),
              ),
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.centerRight, // 靠右对齐
              child: ElevatedButton(
                onPressed: () {
                  onPressed();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text('保存连接'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onPressed() {}
}
