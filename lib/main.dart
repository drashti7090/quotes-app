import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:quotes_app/splash.dart';

void main() {
  runApp(const AppMode());
}

class AppMode extends StatelessWidget {
  const AppMode({super.key});


  @override
  Widget build(BuildContext context) {
    // Lock screen orientation to portraitUp
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      darkTheme: ThemeData.dark(),
      home: const SplashScreenQuotes(),


    );
  }
}



