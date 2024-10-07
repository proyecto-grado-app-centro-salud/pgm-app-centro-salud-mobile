import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:proyecto_grado_flutter/pages/unl_home_page.dart';
import 'package:proyecto_grado_flutter/services/app_router.dart';
import 'package:proyecto_grado_flutter/util/colores.dart';
import 'package:proyecto_grado_flutter/util/locales.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await dotenv.load(fileName: ".env");
  preferences.setString("email", "");
  preferences.setString("token", "");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final localization = FlutterLocalization.instance;

  @override
  void initState() {
    configureLocalization();
    super.initState();
  }

  void configureLocalization() {
    localization.init(mapLocales: LOCALES, initLanguageCode: "es");
    localization.onTranslatedLanguage = onTranslatedLanguage;
  }

  void onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('es', 'ES'),
      localizationsDelegates: localization.localizationsDelegates,
      supportedLocales: localization.supportedLocales,
      title: 'app consultas medicas',
      theme: ThemeData(
        primarySwatch: Colores.color4Material,
      ),
      onGenerateRoute: AppRouter().onGenerateRoute,
      home: HomePage(),
    );
  }
}
