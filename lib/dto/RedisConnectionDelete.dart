import 'dart:ffi';

class RedisconnectionDelete {
  final int id;

  /// 构造函数，带默认值
  RedisconnectionDelete({required this.id}) {
    // 执行参数验证
    _validate();
  }

  /// 参数验证逻辑（对应Java的注解验证）
  void _validate() {
    // 验证主机地址不为空
 // 验证主机地址不为空
    if (id==0) {
      throw ArgumentError.value(id, 'id', 'id cannot be 0');
    }
  }

  /// 转换为JSON格式（用于接口请求）
  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
