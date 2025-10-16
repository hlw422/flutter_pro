import 'package:flutter_pro/dto/RedisConnectionDelete.dart';
import 'package:flutter_pro/dto/RedisConnectionResult.dart';
import 'package:flutter_pro/http/api_service.dart';

class RedisconnectionDeleteService {
  final HttpService _httpService;

  RedisconnectionDeleteService(this._httpService);

  // 登录接口（自动使用固定BaseUrl）
  Future<ApiResponse<RedisConnectionResult>> deleteConnection(RedisconnectionDelete request) async {
    return _httpService.post(
      path: 'redis/delete-connection', // 最终请求地址：_fixedBaseUrl + 'auth/login'
      params: request,
      dataFromJson: (json) => RedisConnectionResult.fromJson(json),
    );
  }
}
