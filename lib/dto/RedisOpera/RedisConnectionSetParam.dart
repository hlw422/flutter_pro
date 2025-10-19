class RedisConnectionSetParam {
  ///键
  final String key;

  ///  值
  final String value;
  /// 构造函数，带默认值
  RedisConnectionSetParam({
    required this.key,
    required this.value,
  }) {
    // 执行参数验证
    _validate();
  }

  /// 参数验证逻辑（对应Java的注解验证）
  void _validate() {
    // 验证主机地址不为空
    if (key.isEmpty) {
      throw ArgumentError("键不能为空");
    }
    if(value.isEmpty){
      throw ArgumentError("值不能为空");
    }
  }

  /// 转换为JSON格式（用于接口请求）
  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value
    };
  }

  /// 从JSON构建对象
  static RedisConnectionSetParam fromJson(Map<String, dynamic> json) {
    return RedisConnectionSetParam(
      key: json['key'] as String,
      value: json['value'] as String,
    );
  }

  @override
  String toString() {
    return 'RedisConnectionSetParam{key: $key, value: $value}';
  }
}
