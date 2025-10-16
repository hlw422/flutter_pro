import 'package:flutter/material.dart';

class RedisConnectionHeader extends StatelessWidget {
  // 定义按钮点击回调参数
  final VoidCallback onAddPressed;
  final VoidCallback onFreshPressed;

  // 构造函数，要求必须传入点击回调
  const RedisConnectionHeader({
    super.key,
    required this.onAddPressed,
    required this.onFreshPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Redis连接",
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
         ElevatedButton(
          onPressed: onFreshPressed, // 使用传入的回调
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.all(10.0),
          ),
          child: Text(
            "刷新",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: onAddPressed, // 使用传入的回调
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.all(10.0),
          ),
          child: Text(
            "+",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
