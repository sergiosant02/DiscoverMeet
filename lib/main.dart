import 'package:discover_meet/src/pages/menu_page.dart';
import 'package:discover_meet/src/providers/page_provider.dart';
import 'package:discover_meet/src/sharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final UserPreferences pref = UserPreferences();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await pref.initPrefs();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PageProvider(),
      child: MaterialApp(
        title: 'Discover meet',
        initialRoute: '/home',
        debugShowCheckedModeBanner: false,
        routes: {'/home': (context) => const MenuPage()},
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
