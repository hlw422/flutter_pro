// 首页
import 'package:flutter/material.dart';
import 'package:flutter_pro/components/CommonDataTable.dart';
import 'package:flutter_pro/components/NoConnection.dart';
import 'package:flutter_pro/components/RedisConnectionHeader.dart';
import 'package:flutter_pro/components/RedisDataTypesList.dart';
import 'package:flutter_pro/components/RedisOperation.dart';
import 'package:flutter_pro/components/addNewConnection.dart';
import 'package:flutter_pro/dto/RedisConnectionConfigDtoList.dart';
import 'package:flutter_pro/dto/RedisConnectionDelete.dart';
import 'package:flutter_pro/dto/RedisConnectionQuery.dart';
import 'package:flutter_pro/http/RedisConnectionDeleteService.dart';
import 'package:flutter_pro/http/RedisConnectionList.dart';
import 'package:flutter_pro/http/api_service.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({super.key});

  @override
  ConnectPageState createState() => ConnectPageState();

}

class ConnectPageState extends State<ConnectPage> {
  bool tableHasData = false;
  List<Map<String, dynamic>> mapList = [];
  
  // 2. 定义 Redis 表格的列配置
  final List<CommonTableColumn> redisColumns = [
    CommonTableColumn(
      title: "连接名称",
      field: "connName",
      tooltip: "Redis连接的标识名称",
    ),
    CommonTableColumn(title: "主机地址", field: "host", tooltip: "Redis服务器IP或域名"),
    CommonTableColumn(
      title: "连接状态",
      field: "status",
      // 自定义单元格（用不同颜色显示状态标签）
      cellBuilder: (cellValue, rowData) {
        final isConnected = cellValue as int;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: isConnected == 0
                ? Colors.green.shade100
                : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            isConnected == 0 ? "已连接" : "未连接",
            style: TextStyle(
              color: isConnected == 0 ? Colors.green : Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
    ),
  ];

  getConnections() async {
    print("start query redis connections");
    final httpService = HttpService();
    final redisService = RedisConnectionListService(httpService);
    final response = await redisService.queryConnections(
      RedisConnectionQuery(query_type: 1),
    );
    if (response.code == 0) {
      final RedisConnectionConfigDtoList data = response.data!;
      if (data.redisConnectionConfigDtoList.isNotEmpty) {
        setState(() {
          tableHasData = true;
          mapList = data.redisConnectionConfigDtoList
              .map((e) => e.toJson())
              .toList();
        });
      } else {
        setState(() {
          tableHasData = false;
        });
        setState(() {
          mapList = [];
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getConnections();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
          child: RedisConnectionHeader(
            onAddPressed: onPressed,
            onFreshPressed: () => getConnections(),
          ),
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
        !tableHasData
            ? NoConnectionPage()
            : CommonDataTable(
                columns: redisColumns,
                dataList: mapList,
                onDelete: _handleDelete, // 启用删除功能
                // 可选配置
                showDeleteColumn: true,
                nameField: 'connName', // 指定使用'username'字段作为名称
                deleteColumnTitle: "操作",
                // 行点击事件（点击行显示详情）
                onRowTap: (rowData) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "选中连接：${rowData['connName']}，地址：${rowData['host']}",
                      ),
                    ),
                  );
                  Navigator.push(
                    context,
                    // 配置跳转动画（MaterialPageRoute自带默认动画）
                    MaterialPageRoute(
                      builder: (context) => RedisOperation(id: rowData['id'] as int), // 目标页面
                      
                    ),
                  );
                },
              ),
      ],
    );
  }

  // 处理删除事件
  void _handleDelete(Map<String, dynamic> rowData, int index) async {
    final httpService = HttpService();
    final redisService = RedisconnectionDeleteService(httpService);
    final response = await redisService.deleteConnection(
      RedisconnectionDelete(id: rowData["id"]),
    );
    if (response.code == 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('已删除: ${rowData['connName']}')));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('删除失败：${response.message}')));
    }
    getConnections();
  }

  void onPressed() async {
    /*
    Navigator.push(
      context,
      // 配置跳转动画（MaterialPageRoute自带默认动画）
      MaterialPageRoute(
        builder: (context) => const AddNewConnection(), // 目标页面
      ),
    );
    */

    final result = await Navigator.push(
      context,
      // 配置跳转动画（MaterialPageRoute自带默认动画）
      MaterialPageRoute(
        builder: (context) => const AddNewConnection(), // 目标页面
      ),
    );
    // 仅当返回“save_success”时才刷新
    if (mounted && result == "save_success") {
      getConnections();
    }
  }
}
