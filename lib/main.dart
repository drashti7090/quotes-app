import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  /// for generate crash
//   FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
//   FirebaseCrashlytics.instance.crash();
}

class AppMode extends StatelessWidget {
  AppMode({super.key});

  String mode = BuildConfiguration.shared.mode;

  @override
  Widget build(BuildContext context) {
    // Lock screen orientation to portraitUp
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      darkTheme: ThemeData.dark(),

      // home: const SplashScreenQuotes(),


    );
  }
}

enum Environment {
  staging,
  production,
}

class BuildConfiguration {
  static final shared = BuildConfiguration();

  late Environment environment;

  Object get baseUrl {
    switch (environment) {
      case Environment.staging:
        return "";
      case Environment.production:
        return "";
    }
  }

  String get socketUrl {
    switch (environment) {
      case Environment.staging:
        return "";
      case Environment.production:
        return "";
    }
  }

  String get mode {
    switch (environment) {
      case Environment.staging:
      // return "TEST";
        return "1234567890";
      case Environment.production:
      // return "PROD";
        return "0987654321";
    }
  }

  String get youtubeId {
    switch (environment) {
      case Environment.staging:
        return "dTu5dTEzVM4";
      case Environment.production:
        return "Njyx5ZuwEHI";
    }
  }
}


