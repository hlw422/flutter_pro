class RedisConnectionQuery {
  final int query_type;

  /// 构造函数，带默认值
  RedisConnectionQuery({
    required this.query_type
  }) {
    // 执行参数验证
    _validate();
  }

  /// 参数验证逻辑（对应Java的注解验证）
  void _validate() {
    // 验证主机地址不为空
    if (query_type==0) {
      throw ArgumentError.value(query_type, 'query_type', 'query_type cannot be 0');
    }
  }

  /// 转换为JSON格式（用于接口请求）
  Map<String, dynamic> toJson() {
    return {
      'query_type': query_type,
    };
  }

}
