import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<NavigationRailDestination> menus = const [
    NavigationRailDestination(icon: Icon(Icons.home), label: Text('主页')),
    NavigationRailDestination(icon: Icon(Icons.folder), label: Text('文件')),
    NavigationRailDestination(icon: Icon(Icons.settings), label: Text('设置')),
  ];

  final List<Widget> pages = const [
    Center(child: Text('主页面板', style: TextStyle(fontSize: 24))),
    Center(child: Text('文件管理', style: TextStyle(fontSize: 24))),
    Center(child: Text('系统设置', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Windows 风格左侧导航
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: (i) => setState(() => selectedIndex = i),
            labelType: NavigationRailLabelType.all,
            backgroundColor: Colors.grey[50],
            destinations: menus,
          ),
          const VerticalDivider(width: 1),
          // 主内容区
          Expanded(child: pages[selectedIndex]),
        ],
      ),
    );
  }
}
