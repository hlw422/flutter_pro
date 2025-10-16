import 'package:flutter/material.dart';
import 'package:flutter_pro/components/dialog/dialog_utils.dart';
import 'package:flutter_pro/dto/RedisConnectionParam.dart';
import 'package:flutter_pro/dto/RedisConnectionResult.dart';
import 'package:flutter_pro/http/RedisConnectionSaveService.dart';
import 'package:flutter_pro/http/RedisConnectionService.dart';
import 'package:flutter_pro/http/api_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddNewConnection extends StatefulWidget {
  const AddNewConnection({super.key});

  @override
  AddNewConnectionState createState() => AddNewConnectionState();
}

class AddNewConnectionState extends State<AddNewConnection> {
  // 在State类中添加一个布尔值控制密码可见性
  bool _isPasswordVisible = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _hostController = TextEditingController();
  final TextEditingController _portController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Widget build(BuildContext context) {
    // 确保有Scaffold作为根组件
    return Scaffold(
      appBar: AppBar(title: const Text('添加新连接')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '连接名称',
                border: OutlineInputBorder(),
                helperText: "例如：公司内网",
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _hostController,
              decoration: const InputDecoration(
                labelText: '主机地址',
                border: OutlineInputBorder(),
                helperText: "例如：192.168.1.100",
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _portController,
              decoration: const InputDecoration(
                labelText: '端口号',
                border: OutlineInputBorder(),
                helperText: "例如：6379",
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible, // 控制密码显示/隐藏
              decoration: InputDecoration(
                labelText: '密码 (可选)',
                border: OutlineInputBorder(),
                // 可选：添加显示/隐藏密码的切换按钮
                // 点击图标切换密码可见性
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.centerRight, // 靠右对齐
              child: ElevatedButton(
                onPressed: () {
                  onCheckConnetion();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text('测试连接'),
              ),
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.centerRight, // 靠右对齐
              child: ElevatedButton(
                onPressed: () {
                  onSaveConnectionPressed();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text('保存连接'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSaveConnectionPressed () async {
    // 初始化服务（无需传入BaseUrl，已固定）
    final httpService = HttpService();
    final redisService = RedisConnectionSaveService(httpService);

    // 调用登录接口
    try {
      //print(" _nameController1"+_nameController.text);
      final response = await redisService.saveConnection(
        RedisConnectionParam(
          host: _hostController.text,
          port: int.parse(_portController.text),
          password: _passwordController.text,
          database: 0,
          timeout: 1000,
          connectionName: _nameController.text,
        ),
      );
      if (response.code == 0) {
        /*
        Fluttertoast.showToast(
          msg: "连接成功",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        */
        Fluttertoast.showToast(
          msg: "保存成功：${response.message}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pop(context,"save_success");
      } else {
        Fluttertoast.showToast(
          msg: "保存失败：${response.message}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.amber,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "保存失败：${e.toString()}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
    // 保存连接

  /*
{
  "host": "106.14.236.60",
  "port": 6379,
  "password": "1234561",
  "database": 0,
  "timeout": 0
}
*/
  void onCheckConnetion() async {
    // 初始化服务（无需传入BaseUrl，已固定）
    final httpService = HttpService();
    final redisService = RedisConnectionService(httpService);

    // 调用登录接口
    try {
      final response = await redisService.checkConnection(
        RedisConnectionParam(
          host: _hostController.text,
          port: int.parse(_portController.text),
          password: _passwordController.text,
          database: 0,
          timeout: 1000,
          connectionName: _nameController.text,
        ),
      );
      if (response.code == 0) {
        /*
        Fluttertoast.showToast(
          msg: "连接成功",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        */
        Fluttertoast.showToast(
          msg: "连接成功：${response.message}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "连接失败：${response.message}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.amber,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "连接失败：${e.toString()}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
