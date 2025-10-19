import 'package:flutter/material.dart';

class RedisDataTypesList extends StatefulWidget {
  const RedisDataTypesList({super.key});

  @override
  State<RedisDataTypesList> createState() => _RedisDataTypesListState();
}

class _RedisDataTypesListState extends State<RedisDataTypesList> {
  // 存储当前选中的数据类型
  String? _selectedType;
  
  // 定义Redis数据类型及其对应的操作
  final Map<String, List<String>> _redisOperations = {
    "String": ["SET", "GET", "INCR", "DECR", "APPEND", "STRLEN"],
    "Hash": ["HSET", "HGET", "HGETALL", "HDEL", "HLEN", "HKEYS", "HVALS"],
    "List": ["LPUSH", "RPUSH", "LPOP", "RPOP", "LRANGE", "LLEN", "LTRIM"],
    "Set": ["SADD", "SMEMBERS", "SREM", "SCARD", "SISMEMBER", "SINTER"],
    "Sorted Set": ["ZADD", "ZRANGE", "ZREVRANGE", "ZREM", "ZCARD", "ZSCORE"],
    "Bitmap": ["SETBIT", "GETBIT", "BITCOUNT", "BITOP"],
    "HyperLogLog": ["PFADD", "PFCOUNT", "PFMERGE"],
    "Geospatial": ["GEOADD", "GEODIST", "GEORADIUS", "GEOPOS"]
  };

  // 显示操作选项对话框
  void _showOperationsDialog(String type) {
    setState(() {
      _selectedType = type;
    });
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$type 操作'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _redisOperations[type]!.map((operation) {
              return ListTile(
                title: Text(operation),
                onTap: () {
                  // 处理操作选择
                  _handleOperationSelection(type, operation);
                  Navigator.pop(context);
                },
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              );
            }).toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
        ],
      ),
    );
  }
  
  // 处理操作选择
  void _handleOperationSelection(String type, String operation) {
    // 这里可以添加具体的操作逻辑
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('选择了 $type 类型的 $operation 操作'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Redis 数据类型'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: _redisOperations.keys.map((type) {
          // 根据类型选择对应的图标
          IconData icon;
          switch (type) {
            case "String":
              icon = Icons.text_fields;
              break;
            case "Hash":
              icon = Icons.grid_on;
              break;
            case "List":
              icon = Icons.list;
              break;
            case "Set":
              icon = Icons.circle_outlined;
              break;
            case "Sorted Set":
              icon = Icons.sort;
              break;
            case "Bitmap":
              icon = Icons.grid_4x4_sharp;
              break;
            case "HyperLogLog":
              icon = Icons.calculate;
              break;
            case "Geospatial":
              icon = Icons.location_on;
              break;
            default:
              icon = Icons.data_object;
          }

          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: Icon(icon, color: Colors.deepPurple, size: 28),
              title: Text(
                type,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text('点击查看 ${type} 类型的操作'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _showOperationsDialog(type),
              // 选中状态高亮
              selected: _selectedType == type,
              selectedColor: Colors.white,
              selectedTileColor: Colors.deepPurple[100],
            ),
          );
        }).toList(),
      ),
    );
  }
}