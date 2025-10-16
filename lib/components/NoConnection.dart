import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoConnectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
               //自定义图标
        SvgPicture.asset(
          "assets/icons/no-connection.svg", // 自定义SVG路径
          width: 60,
          height: 60,
          colorFilter: ColorFilter.mode(Colors.grey[400]!, BlendMode.srcIn),
        ),

        const SizedBox(height: 16),
        // 提示文本
        const Text(
          "暂无连接数据",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        const Text(
          "请添加连接或检查网络状态",
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}
