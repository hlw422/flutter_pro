import 'package:flutter_pro/dto/RedisConnectionParam.dart';
import 'package:flutter_pro/dto/RedisConnectionResult.dart';
import 'package:flutter_pro/http/api_service.dart';

class RedisConnectionSaveService {
  final HttpService _httpService;

  RedisConnectionSaveService(this._httpService);

  // 登录接口（自动使用固定BaseUrl）
  Future<ApiResponse<RedisConnectionResult>> saveConnection(RedisConnectionParam request) async {
    return _httpService.post(
      path: 'redis/save-connection', // 最终请求地址：_fixedBaseUrl + 'auth/login'
      params: request,
      dataFromJson: (json) => RedisConnectionResult.fromJson(json),
    );
  }
}
