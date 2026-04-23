import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  String content = "暂无内容";

  // ========== 写入文件 ==========
  Future<void> writeFile() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/my_notes.txt');
    await file.writeAsString('这是 Windows 桌面应用写入的测试内容');
    setState(() => content = "写入成功：${file.path}");
  }

  // ========== 读取文件 ==========
  Future<void> readFile() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/my_notes.txt');
      final str = await file.readAsString();
      setState(() => content = "读取成功：\n$str");
    } catch (e) {
      setState(() => content = "无文件，请先写入");
    }
  }

  // ========== 选择文件 ==========
  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() => content = "选择文件：\n${result.files.single.path}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 左侧导航
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: (i) => setState(() => selectedIndex = i),
            labelType: NavigationRailLabelType.all,
            backgroundColor: Colors.grey[50],
            destinations: const [
              NavigationRailDestination(icon: Icon(Icons.home), label: Text('主页')),
              NavigationRailDestination(icon: Icon(Icons.folder), label: Text('文件')),
              NavigationRailDestination(icon: Icon(Icons.settings), label: Text('设置')),
            ],
          ),
          const VerticalDivider(width: 1),
          // 主内容
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Windows 文件操作", style: TextStyle(fontSize: 22)),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 10,
                    children: [
                      ElevatedButton(onPressed: writeFile, child: const Text("写入文件")),
                      ElevatedButton(onPressed: readFile, child: const Text("读取文件")),
                      ElevatedButton(onPressed: pickFile, child: const Text("选择文件")),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text("结果：", style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: SingleChildScrollView(child: Text(content)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
