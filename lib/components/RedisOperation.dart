import 'package:flutter/material.dart';
import 'package:flutter_pro/components/redis_command/string_command_page.dart';

class RedisOperation extends StatefulWidget {
  final int id;
  const RedisOperation({super.key, required this.id});
  @override
  _RedisOperationState createState() => _RedisOperationState();
}

class _RedisOperationState extends State<RedisOperation>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = [
    'String',
    'List',
    'Set',
    'Hash',
    'Zset',
    'a',
    'b',
    'c',
    'd',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);

    _tabController.addListener(() {
      print(_tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose(); // 销毁控制器
    super.dispose();
  }

  // 根据标签名展示不同内容
  Widget _buildTabContent(String tabName) {
    switch (tabName) {
      case 'String':
        return StringCommandPage(id:widget.id);
      /*
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.text_fields, size: 60, color: Colors.red),
            const SizedBox(height: 10),
            const Text(
              'String 类型操作：\n用于保存简单的字符串、数字等。',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        );
        */
      case 'Hash':
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.dashboard_customize,
              size: 60,
              color: Colors.orange,
            ),
            const SizedBox(height: 10),
            const Text(
              'Hash 类型操作：\n用于存储对象（键值对集合）。',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        );
      case 'List':
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.list, size: 60, color: Colors.blue),
            const SizedBox(height: 10),
            const Text(
              'List 类型操作：\n可以存储多个有序元素（类似队列或栈）。',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        );
      case 'Set':
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.group_work, size: 60, color: Colors.green),
            const SizedBox(height: 10),
            const Text(
              'Set 类型操作：\n存储不重复的元素集合。',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        );
      case 'ZSet':
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.sort, size: 60, color: Colors.purple),
            const SizedBox(height: 10),
            const Text(
              'ZSet（有序集合）类型操作：\n带有分数的排序集合。',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        );
      default:
        return const Center(child: Text("未知类型"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Redis 操作"),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((tab) {
          return Center(child: _buildTabContent(tab));
        }).toList(),
      ),
    );
  }
}
