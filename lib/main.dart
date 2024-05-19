import 'package:fluent_ui/fluent_ui.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sale_safe/screen/main_page.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();
  await GetStorage.init();
  WindowOptions windowOptions = const WindowOptions(
    minimumSize: Size(1200, 800),
    center: true,
    skipTaskbar: false,
    title: "Sale Safe",
   
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  const FluentApp(
      title: "Sale Safe",
      
      home: MainPage(),
    );
  }
}
