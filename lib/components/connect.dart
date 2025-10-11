// 首页
import 'package:flutter/material.dart';
import 'package:flutter_pro/components/RedisConnectionHeader.dart';
import 'package:flutter_pro/components/addNewConnection.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({super.key});

  @override
  ConnectPageState createState() => ConnectPageState();
}

class ConnectPageState extends State<ConnectPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
          child: RedisConnectionHeader(onAddPressed: onPressed),
        ),
        SizedBox(height: 10),
        // 水平分割线
        Divider(
          height: 1, // 分割线高度（包含上下间距）
          thickness: 1, // 分割线实际厚度
          color: Colors.grey[300], // 分割线颜色
          indent: 16, // 左侧缩进距离
          endIndent: 16, // 右侧缩进距离
        ),
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

  void onPressed() {
    Navigator.push(
      context,
      // 配置跳转动画（MaterialPageRoute自带默认动画）
      MaterialPageRoute(
        builder: (context) => const AddNewConnection(), // 目标页面
      ),
    );
  }
}
