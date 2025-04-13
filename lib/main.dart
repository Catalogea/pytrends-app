import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pytrends/services/theme_provider.dart';
import 'package:pytrends/screens/home_screen.dart';
import 'package:pytrends/screens/trends_screen.dart';
import 'package:pytrends/screens/interests_screen.dart';
import 'package:pytrends/screens/editor_screen.dart';
import 'package:pytrends/screens/articles_screen.dart';
import 'package:pytrends/screens/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'YOUR_API_KEY',
      authDomain: 'YOUR_PROJECT_ID.firebaseapp.com',
      projectId: 'YOUR_PROJECT_ID',
      storageBucket: 'YOUR_PROJECT_ID.appspot.com',
      messagingSenderId: 'YOUR_SENDER_ID',
      appId: 'YOUR_APP_ID',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'PyTrends Content Generator',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeProvider.themeMode,
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => const HomeScreen(),
              '/trends': (context) => const TrendsScreen(),
              '/interests': (context) => const InterestsScreen(),
              '/editor': (context) => const EditorScreen(),
              '/articles': (context) => const ArticlesScreen(),
              '/settings': (context) => const SettingsScreen(),
            },
          );
        },
      ),
    );
  }
}