import 'package:fluent_ui/fluent_ui.dart';
import 'package:librarysec/checkout.dart';
import 'package:window_manager/window_manager.dart';
import 'package:librarysec/login.dart';

const String apptitle = 'KNUST LIBRARY PORTAL';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setTitle(apptitle);
    await windowManager.setTitleBarStyle(TitleBarStyle.normal);
    await windowManager.setBackgroundColor(Colors.transparent);
    //await windowManager.setSize(const Size(755, 545));
    await windowManager.setMinimumSize(const Size(755, 545));
    await windowManager.center();
    await windowManager.show();
    await windowManager.setSkipTaskbar(false);
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'KNUST LIBRARY PORTAL',
      color: Colors.purple,
      theme: ThemeData(
        brightness: Brightness.light,
        accentColor: Colors.purple,
      ),
      darkTheme:
          ThemeData(brightness: Brightness.dark, accentColor: Colors.orange),
      home: const Login(),
    );
  }
}
