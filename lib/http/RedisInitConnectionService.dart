import 'package:flutter_pro/dto/RedisConnectionResult.dart';
import 'package:flutter_pro/dto/RedisOpera/RedisConnectionSetParam.dart';
import 'package:flutter_pro/dto/RedisOpera/RedisInitConnectionPara.dart';
import 'package:flutter_pro/http/api_service.dart';

class RedisInitConnectionService {
  final HttpService _httpService;

  RedisInitConnectionService(this._httpService);

  // 登录接口（自动使用固定BaseUrl）
  Future<ApiResponse<RedisConnectionResult>> initCommand(RedisInitConnectionPara request) async {
    return _httpService.post(
      path: 'redis/string/init-connection', // 最终请求地址：_fixedBaseUrl + 'auth/login'
      params: request,
      dataFromJson: (json) => RedisConnectionResult.fromJson(json),
    );
  }
}
