import 'package:flutter_pro/dto/RedisConnectionConfigDto.dart';

class RedisConnectionConfigDtoList {
  final List<RedisConnectionConfigDto> redisConnectionConfigDtoList;

  RedisConnectionConfigDtoList({required this.redisConnectionConfigDtoList});

  /// 从JSON数据解析出RedisConnectionConfigDtoList对象
  /// [json] 格式应为: {"redisConnectionConfigDtoList": [{}, {}, ...]}
  factory RedisConnectionConfigDtoList.fromJsonOld(Map<String, dynamic> json) {
    // 从JSON中获取列表数据
    var list = json['redisConnectionConfigDtoList'] as List;
    
    // 将列表中的每个JSON对象转换为RedisConnectionConfigDto对象
    List<RedisConnectionConfigDto> dtoList = list.map((i) => 
        RedisConnectionConfigDto.fromJson(i as Map<String, dynamic>)
    ).toList();
    
    // 返回解析后的对象
    return RedisConnectionConfigDtoList(
      redisConnectionConfigDtoList: dtoList
    );
  }

  /// 从JSON列表解析出RedisConnectionConfigDtoList对象
  /// [jsonList] 格式应为: [{}, {}, ...]（直接传入数组）
  factory RedisConnectionConfigDtoList.fromJson(List<dynamic> jsonList) {
    // 将列表中的每个JSON对象转换为RedisConnectionConfigDto对象
    List<RedisConnectionConfigDto> dtoList = jsonList.map((item) {
      // 确保每个元素是Map类型
      if (item is Map<String, dynamic>) {
        return RedisConnectionConfigDto.fromJson(item);
      } else {
        throw FormatException('列表项不是有效的JSON对象: $item');
      }
    }).toList();

    return RedisConnectionConfigDtoList(
      redisConnectionConfigDtoList: dtoList
    );
  }
}
