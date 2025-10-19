class RedisInitConnectionPara {
  //唯一ID
  final int id;
  /// 构造函数，带默认值
  RedisInitConnectionPara({
    required this.id
  }) {
    // 执行参数验证
    _validate();
  }

  /// 参数验证逻辑（对应Java的注解验证）
  void _validate() {
    // 验证主机地址不为空
    if (id==0) {
      throw ArgumentError("Id 不能为 0");
    }
  }

  /// 转换为JSON格式（用于接口请求）
  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }

  /// 从JSON构建对象
  static RedisInitConnectionPara fromJson(Map<String, dynamic> json) {
    return RedisInitConnectionPara(
      id: json['id'],

    );
  }

  @override
  String toString() {
    return 'RedisInitConnectionPara{key: $id}';
  }
}
