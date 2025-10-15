import 'package:flutter_pro/dto/RedisConnectionParam.dart';
import 'package:flutter_pro/dto/RedisConnectionResult.dart';
import 'package:flutter_pro/http/api_service.dart';

class RedisConnectionService {
  final HttpService _httpService;

  RedisConnectionService(this._httpService);

  // 登录接口（自动使用固定BaseUrl）
  Future<ApiResponse<RedisConnectionResult>> checkConnection(RedisConnectionParam request) async {
    return _httpService.post(
      path: 'redis/check-connection', // 最终请求地址：_fixedBaseUrl + 'auth/login'
      params: request,
      dataFromJson: (json) => RedisConnectionResult.fromJson(json),
    );
  }
}
