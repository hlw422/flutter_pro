import 'package:flutter_pro/dto/RedisConnectionResult.dart';
import 'package:flutter_pro/dto/RedisOpera/RedisConnectionSetParam.dart';
import 'package:flutter_pro/http/api_service.dart';

class RedisConnectionSetService {
  final HttpService _httpService;

  RedisConnectionSetService(this._httpService);

  // 登录接口（自动使用固定BaseUrl）
  Future<ApiResponse<RedisConnectionResult>> setCommand(RedisConnectionSetParam request) async {
    return _httpService.post(
      path: 'redis/string/set', // 最终请求地址：_fixedBaseUrl + 'auth/login'
      params: request,
      dataFromJson: (json) => RedisConnectionResult.fromJson(json),
    );
  }
}
