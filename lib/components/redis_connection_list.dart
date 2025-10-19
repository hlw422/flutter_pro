import 'package:flutter/material.dart';

class RedisConnectionList extends StatefulWidget {
  const RedisConnectionList({super.key});
  @override
  _RedisConnectionListState createState() => _RedisConnectionListState();
}

class _RedisConnectionListState extends State<RedisConnectionList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
       // 3. 外层加滚动，避免表格超出屏幕宽度
        scrollDirection: Axis.horizontal,
      child: Table(
  
  
      )
    );
  }
}

