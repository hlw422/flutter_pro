import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Redisoperation extends StatefulWidget {
  const Redisoperation({super.key});

  @override
  State<Redisoperation> createState() => _RedisoperationState();
}

class _RedisoperationState extends State<Redisoperation> {
  String _result = "";
  final String baseUrl = "http://localhost:8080/redis"; // Spring Boot 后端地址

  Future<void> callApi(String endpoint) async {
    try {
      final res = await http.get(Uri.parse('$baseUrl/$endpoint'));
      setState(() => _result = res.body);
    } catch (e) {
      setState(() => _result = "请求出错: $e");
    }
  }

  Widget _buildButton(String label, String endpoint) {
    return ElevatedButton(
      onPressed: () => callApi(endpoint),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(label),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Redis 功能演示')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _buildButton("String", "string"),
                _buildButton("Hash", "hash"),
                _buildButton("List", "list"),
                _buildButton("Set", "set"),
                _buildButton("ZSet", "zset"),
                _buildButton("Bitmap", "bitmap"),
                _buildButton("HyperLogLog", "hyperloglog"),
                _buildButton("Geo", "geo"),
                _buildButton("Stream", "stream"),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _result.isEmpty ? "点击上方按钮开始测试" : _result,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
