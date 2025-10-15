class RedisConnectionResult {
  /// Redis主机地址
  final String host;

  /// Redis端口
  final int port;

  /// 数据库索引
  final int database;

  /// 是否连接成功
  final bool connected;

  /// 连接耗时(毫秒)
  final int connectTime;

  /// Redis服务器版本
  final String? redisVersion;

  /// 错误信息，如果连接失败则不为空
  final String? errorMessage;

  /// 命令执行测试是否成功
  final bool commandTestSuccess;

  /// 构造函数
  RedisConnectionResult({
    required this.host,
    required this.port,
    required this.database,
    required this.connected,
    required this.connectTime,
    this.redisVersion,
    this.errorMessage,
    required this.commandTestSuccess,
  });

  /// 从JSON构建对象
  static RedisConnectionResult fromJson(Map<String, dynamic> json) {
    return RedisConnectionResult(
      host: json['host'] as String,
      port: json['port'] as int,
      database: json['database'] as int,
      connected: json['connected'] as bool,
      connectTime: json['connectTime'] as int,
      redisVersion: json['redisVersion'] as String?,
      errorMessage: json['errorMessage'] as String?,
      commandTestSuccess: json['commandTestSuccess'] as bool? ?? false,
    );
  }

  /// 转换为JSON格式
  Map<String, dynamic> toJson() {
    return {
      'host': host,
      'port': port,
      'database': database,
      'connected': connected,
      'connectTime': connectTime,
      'redisVersion': redisVersion,
      'errorMessage': errorMessage,
      'commandTestSuccess': commandTestSuccess,
    };
  }

  @override
  String toString() {
    return 'RedisConnectionResult{'
        'host: $host, '
        'port: $port, '
        'database: $database, '
        'connected: $connected, '
        'connectTime: $connectTime ms, '
        'redisVersion: $redisVersion, '
        'errorMessage: $errorMessage, '
        'commandTestSuccess: $commandTestSuccess'
        '}';
  }
}
