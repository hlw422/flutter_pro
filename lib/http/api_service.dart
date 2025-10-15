import 'dart:convert';
import 'package:dio/dio.dart';

// 基础URL固定配置
const String _fixedBaseUrl = "http://192.168.0.122:9002/api/";

// 通用响应模型
class ApiResponse<T> {
  final int code;
  final String message;
  final T? data;

  ApiResponse({required this.code, required this.message, this.data});

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJson,
  ) {
    return ApiResponse(
      code: json['code'] as int,
      message: json['message'] as String,
      data: json['data'] != null ? fromJson(json['data']) : null,
    );
  }
}

// HTTP服务类（固定BaseUrl）
class HttpService {
  final Dio _dio;

  // 初始化时固定BaseUrl，不可外部修改
  HttpService() : _dio = Dio() {
    _dio.options = BaseOptions(
      baseUrl: _fixedBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    );

    // 添加日志拦截器
    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );
  }

  // 通用POST请求方法
  Future<ApiResponse<T>> post<T>({
    required String path,
    required dynamic params, // 入参为实现toJson的类
    required T Function(dynamic) dataFromJson, // data反序列化方法
  }) async {
    try {
      // 将入参类转换为JSON
      final jsonData = params.toJson();

      // 发送请求（路径会自动拼接在固定BaseUrl后）
      final response = await _dio.post(path, data: jsonData);

      // 解析响应
      return ApiResponse.fromJson(
        response.data as Map<String, dynamic>,
        dataFromJson,
      );
    } on DioError catch (e) {
      // 处理Dio错误
      throw Exception(_getDioErrorMsg(e));
    } catch (e) {
      // 处理其他错误
      throw Exception('请求失败: ${e.toString()}');
    }
  }

  // 解析Dio错误信息
  String _getDioErrorMsg(DioError error) {
    switch (error.type) {
      case DioErrorType.connectionTimeout:
        throw Exception('连接超时');
      case DioErrorType.sendTimeout:
        throw Exception('发送超时');
      case DioErrorType.receiveTimeout:
        throw Exception('接收超时');
      case DioErrorType.badResponse: // 这里是修正后的枚举值
        throw Exception('请求失败: ${error.response?.statusCode}');
      case DioErrorType.cancel:
        throw Exception('请求被取消');
      default:
        throw Exception('网络错误: ${error.message}');
    }
  }
}
