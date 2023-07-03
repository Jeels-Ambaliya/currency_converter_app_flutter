import 'package:currency_converter_app_flutter/controllers/Provider/amount_modal.dart';
import 'package:currency_converter_app_flutter/controllers/Provider/theme_provider.dart';
import 'package:currency_converter_app_flutter/views/screens/home_screen.dart';
import 'package:currency_converter_app_flutter/views/screens/splesh_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/Provider/from_provider.dart';
import 'controllers/Provider/to_provider.dart';

void main() {
  runApp(
    const My_App(),
  );
}

class My_App extends StatefulWidget {
  const My_App({Key? key}) : super(key: key);

  @override
  State<My_App> createState() => _My_AppState();
}

class _My_AppState extends State<My_App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => FromProvider()),
        ChangeNotifierProvider(create: (context) => ToProvider()),
        ChangeNotifierProvider(create: (context) => AmountProvider()),
      ],
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(useMaterial3: true),
          darkTheme: ThemeData.dark(useMaterial3: true),
          themeMode:
              (Provider.of<ThemeProvider>(context).themeModal.isDark == false)
                  ? ThemeMode.light
                  : ThemeMode.dark,
          initialRoute: 'Splash_Screen',
          routes: {
            'Home_Screen': (context) => const Home_Screen(),
            'Splash_Screen': (context) => const Splash_Screen(),
            // 'CurrentRateScreen': (context) => CurrentRateScreen(),
          },
        );
      },
    );
  }
}
