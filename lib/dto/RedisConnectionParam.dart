class RedisConnectionParam {
  /// Redis服务器主机地址
  final String host;

  /// Redis服务器端口，默认6379
  final int port;

  /// Redis密码，可为空
  final String? password;

  /// 数据库索引，默认0（0-15之间）
  final int database;

  /// 连接超时时间(毫秒)，默认5000
  final int timeout;

  final String connectionName;

  /// 构造函数，带默认值
  RedisConnectionParam({
    required this.host,
    required this.connectionName,
    this.port = 6379,
    this.password,
    this.database = 0,
    this.timeout = 1000,
  }) {
    // 执行参数验证
    _validate();
  }

  /// 参数验证逻辑（对应Java的注解验证）
  void _validate() {
    // 验证主机地址不为空
    if (host.isEmpty) {
      throw ArgumentError("主机地址不能为空");
    }
    if(connectionName.isEmpty){
      throw ArgumentError("连接名称不能为空");
    }

    // 验证端口为正数
    if (port <= 0) {
      throw ArgumentError("端口必须为正数");
    }

    // 验证数据库索引在0-15之间
    if (database < 0 || database > 15) {
      throw ArgumentError("数据库索引必须在0-15之间");
    }

    // 验证超时时间不能为负数
    if (timeout < 0) {
      throw ArgumentError("超时时间不能为负数");
    }
  }

  /// 转换为JSON格式（用于接口请求）
  Map<String, dynamic> toJson() {
    return {
      'host': host,
      'port': port,
      'password': password,
      'database': database,
      'timeout': timeout,
      'connectionName':connectionName
    };
  }

  /// 从JSON构建对象
  static RedisConnectionParam fromJson(Map<String, dynamic> json) {
    return RedisConnectionParam(
      host: json['host'] as String,
      port: json['port'] as int? ?? 6379,
      password: json['password'] as String?,
      database: json['database'] as int? ?? 0,
      timeout: json['timeout'] as int? ?? 1000,
      connectionName: json['host'] as String,
    );
  }

  @override
  String toString() {
    return 'RedisConnectionParam{host: $host, port: $port, database: $database, timeout: $timeout}';
  }
}
