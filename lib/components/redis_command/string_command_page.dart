import 'package:flutter/material.dart';
import 'package:flutter_pro/dto/RedisOpera/RedisConnectionSetParam.dart';
import 'package:flutter_pro/dto/RedisOpera/RedisInitConnectionPara.dart';
import 'package:flutter_pro/http/RedisConnectionSetService.dart';
import 'package:flutter_pro/http/RedisInitConnectionService.dart';
import 'package:flutter_pro/http/api_service.dart';

class StringCommandPage extends StatefulWidget {
  final int id;
  const StringCommandPage({super.key, required this.id});
  @override
  _StringCommandPageState createState() => _StringCommandPageState();
}

class _StringCommandPageState extends State<StringCommandPage> {
 String? _errorMessage;
  @override
  void initState() {
    super.initState(); // 必须首先调用父类初始化（同步执行）
    _initRedisCommand(); // 调用异步初始化方法
  }

  // 单独的异步方法处理初始化逻辑
  Future<void> _initRedisCommand() async {
    try {
      // 初始化服务
      final httpService = HttpService();
      final redisService = RedisInitConnectionService(httpService);
      
      // 执行异步操作
      final response = await redisService.initCommand(
        RedisInitConnectionPara(id: widget.id),
      );

      // 处理响应
      if (response.code != 0) {
        _handleError("初始化失败: ${response.message ?? '未知错误'}");
      } else {

        }
      }
     catch (e) {
      // 捕获网络异常、解析异常等
      _handleError("操作异常: ${e.toString()}");
    }
  }

  // 错误处理方法（封装重复逻辑）
  void _handleError(String message) {
    if (mounted) {
      setState(() {
        _errorMessage = message;
      });
      // 可选：显示错误提示对话框
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }


  // String 类型输入框控制器
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  Future<String> DoSetCommand() async {
    final httpService = HttpService();
    final redisService = RedisConnectionSetService(httpService);
    final response = await redisService.setCommand(
      RedisConnectionSetParam(
        key: _keyController.text.trim(),
        value: _valueController.text.trim(),
      ),
    );
    return response.message ?? "未知错误";
  }

  String _selectedCommand = "SET";

  String _result = ""; // 模拟执行结果显示
  // 模拟执行 Redis 操作
  void _simulateRedisCommand(String command, String message) {
    switch (command) {
      case "SET":
        Future<String> result = DoSetCommand();
        result.then((value) {
          setState(() {
            _result = "执行命令: $command\n结果: $value";
          });
        });
    }
  }

  @override
  Widget build(Object context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "String 类型操作示例",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // 键名输入
          TextField(
            controller: _keyController,
            decoration: const InputDecoration(
              labelText: "键名 (key)",
              hintText: "请输入 key，例如：user:name",
              prefixIcon: Icon(Icons.vpn_key),
            ),
          ),
          const SizedBox(height: 10),

          // 值输入框，仅在 SET 时使用
          if (_selectedCommand == "SET")
            TextField(
              controller: _valueController,
              decoration: const InputDecoration(
                labelText: "值 (value)",
                hintText: "请输入 value，例如：Tom",
                prefixIcon: Icon(Icons.text_fields),
              ),
            ),

          const SizedBox(height: 20),

          // 按钮行
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  setState(() => _selectedCommand = "SET");
                  _simulateRedisCommand("SET", "");
                },
                icon: const Icon(Icons.save),
                label: const Text("SET"),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() => _selectedCommand = "GET");
                  _simulateRedisCommand(
                    "GET ${_keyController.text}",
                    "查询结果: 示例值",
                  );
                },
                icon: const Icon(Icons.search),
                label: const Text("GET"),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() => _selectedCommand = "DEL");
                  _simulateRedisCommand("DEL ${_keyController.text}", "删除成功");
                },
                icon: const Icon(Icons.delete),
                label: const Text("DEL"),
              ),
            ],
          ),

          const SizedBox(height: 30),
          const Divider(),
          Text(_result, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
