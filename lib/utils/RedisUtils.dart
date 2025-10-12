import 'package:redis/redis.dart';
import 'dart:async';

class RedisUtils {
  // 建立连接并返回命令执行对象和连接实例
  static Future<Map<String, dynamic>?> connect({
    required String host,
    required int port,
    String? password,
    Duration timeout = const Duration(seconds: 5),
  }) async {
    try {
      // 创建连接实例
      final connection = RedisConnection();
      
      // 连接到Redis服务器（带超时）
      final command = await connection.connect(host, port)
          .timeout(timeout, onTimeout: () {
        throw TimeoutException('连接超时，请检查网络和地址');
      });
      
      // 如果需要密码，进行认证
      if (password?.isNotEmpty ?? false) {
        final authResult = await command.send_object(['AUTH', password]);
        if (authResult is Error) {
          throw Exception('认证失败: ${authResult.toString()}');
        }
      }
      
      // 返回命令对象和连接实例（用于关闭连接）
      return {
        'command': command,
        'connection': connection
      };
    } catch (e) {
      print('Redis连接失败: $e');
      return null;
    }
  }

  // 验证连接是否有效
  static Future<String> checkConnection({
    required String host,
    required int port,
    String? password,
  }) async {
    // 存储命令对象和连接实例
    Command? command;
    RedisConnection? connection;
    
    try {
      // 建立连接
      final result = await connect(
        host: host,
        port: port,
        password: password,
      );
      
      if (result == null) {
        return '连接失败: 无法建立连接';
      }
      
      command = result['command'] as Command;
      connection = result['connection'] as RedisConnection;
      
      // 发送PING命令验证
      final pingResult = await command.send_object(['PING']);
      if (pingResult == 'PONG') {
        return '连接成功';
      } else {
        return '连接失败: 服务器未响应PING';
      }
    } on TimeoutException catch (e) {
      return e.message ?? '连接超时';
    } catch (e) {
      return '连接失败: $e';
    } finally {
      // 关闭连接（通过RedisConnection实例）
      if (connection != null) {
        // 关闭底层socket连接
        connection.close();
      }
    }
  }
}
