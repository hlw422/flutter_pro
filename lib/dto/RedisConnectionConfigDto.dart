import 'dart:ffi';

class RedisConnectionConfigDto {
  final int id;
  final String connName;
  final String host;
  final int status; // 假设后端有此状态字段

  RedisConnectionConfigDto({
    required this.id,
    required this.connName,
    required this.host,
    required this.status,
  });

   // 从JSON解析单个Redis连接配置
  factory RedisConnectionConfigDto.fromJson(Map<String, dynamic> json) {
    return RedisConnectionConfigDto(
      id: json['id'] as int,
      connName: json['connName'] as String,
      host: json['host'] as String,
      status: json['status']as int, // 默认为false
    );
  }
    // 添加toJson方法，将对象转换为Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'connName': connName,
      'host': host,
      'status': status,
    };
  }
}
