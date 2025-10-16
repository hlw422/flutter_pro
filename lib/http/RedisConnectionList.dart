import 'package:flutter_pro/dto/RedisConnectionConfigDto.dart';
import 'package:flutter_pro/dto/RedisConnectionConfigDtoList.dart';
import 'package:flutter_pro/dto/RedisConnectionQuery.dart';
import 'package:flutter_pro/http/api_service.dart';
class RedisConnectionListService {
  final HttpService _httpService;

  RedisConnectionListService(this._httpService);

  // 登录接口（自动使用固定BaseUrl）
  Future<ApiResponse<RedisConnectionConfigDtoList>> queryConnections(RedisConnectionQuery request) async {
    return _httpService.post(
      path: 'redis/query-connections', // 最终请求地址：_fixedBaseUrl + 'auth/login'
      params: request, // 入参为实现toJson的类
      dataFromJson: (json) => RedisConnectionConfigDtoList.fromJson(json),
    );
  }
}
