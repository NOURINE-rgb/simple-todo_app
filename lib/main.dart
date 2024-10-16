import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/Screen/main_screen.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(const MyApp()),
  );
}

final ColorScheme color = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 54, 188, 245),
    brightness: Brightness.light);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: color,
        scaffoldBackgroundColor: color.primary,
        appBarTheme: AppBarTheme.of(context).copyWith(
          backgroundColor: color.primary.withOpacity(0.7),
          foregroundColor: color.onPrimary,
        ),
        textTheme: GoogleFonts.latoTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: color.primaryContainer,
            foregroundColor: color.onPrimaryContainer,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: color.primary,
            foregroundColor: color.onPrimary,
          ),
        ),
      ),
      home: const MainScreen(),
    );
  }
}
// nwid animation nzid mon7ana nzid ....