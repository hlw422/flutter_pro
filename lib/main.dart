import 'package:flutter/material.dart';
import 'package:flutter_pro/components/connect.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '底部导航示例',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BottomNavigationPage(),
    );
  }
}

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  // 当前选中的索引
  int _currentIndex = 0;

  // 导航对应的页面
  final List<Widget> _pages = [
    const ConnectPage(),
    const MessagePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Redis 连接工具'),
      ),
      // 显示当前选中的页面
      body: _pages[_currentIndex],
      // 底部导航栏
      bottomNavigationBar: BottomNavigationBar(
        // 当前选中的索引
        currentIndex: _currentIndex,
        // 点击事件
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        // 导航项
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.storage),
            label: '连接',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.terminal),
            label: '命令',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: '数据',
          ),
        ],
        // 可选配置
        type: BottomNavigationBarType.fixed, // 固定样式（多于3项时需要）
        selectedItemColor: Colors.blue, // 选中项颜色
        unselectedItemColor: Colors.grey, // 未选中项颜色
        selectedFontSize: 12,
        unselectedFontSize: 12,
      ),
    );
  }
}

// 首页
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('首页内容'),
    );
  }
}

// 消息页
class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('消息内容'),
    );
  }
}

// 我的页面
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('个人中心'),
    );
  }
}
