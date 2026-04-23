import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:system_tray/system_tray.dart';
import 'home_page.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ========== Windows 窗口初始化 ==========
  await windowManager.ensureInitialized();
  const windowOptions = WindowOptions(
    title: 'Windows 专业工具',
    size: Size(900, 600),         // 初始大小
    minimumSize: Size(800, 500),  // 最小大小（限制窗口）
    maximumSize: Size(1000, 700), // 最大大小
    center: true,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal, // 正常 Windows 标题栏
  );
  await windowManager.configure(windowOptions);

  // ========== 系统托盘图标 ==========
  final systemTray = SystemTray();
  await systemTray.initSystemTray(
    title: "Windows 工具",
    iconPath: "icon.ico", // 可放自己图标
  );
  systemTray.registerSystemTrayEventHandler((event) {
    if (event == SystemTrayEventType.onTrayMouseClick) {
      windowManager.show();
      windowManager.focus();
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Windows 工具',
      theme: windowsTheme,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
