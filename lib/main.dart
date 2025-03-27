import 'package:flutter/material.dart';
import 'package:expense_tracker/expenses.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 18, 41, 50));

var kDarkColorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 5, 99, 125),
brightness: Brightness.dark);
bool isDark = true;

void main() {
  runApp(
    Myapp()
  );
}

class Myapp extends StatefulWidget{
  const Myapp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Myapp();
  }
}

class _Myapp extends State<Myapp>{


  void _toggleTheme(){
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  Widget build(context){
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kDarkColorScheme.onSecondary,
            foregroundColor: Colors.white),
        cardTheme: CardTheme().copyWith(
          color: kDarkColorScheme.secondaryFixedDim,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.onSecondaryFixedVariant,
          ),
        ),
        textTheme: TextTheme().copyWith(
          titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        ),
      ),

      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: Colors.white),
        cardTheme: CardTheme().copyWith(
          color: kColorScheme.secondaryFixedDim,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.secondaryFixedDim,
          ),
        ),
        textTheme: TextTheme().copyWith(
          titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        ),
      ),
      themeMode: isDark? ThemeMode.dark : ThemeMode.light,
      home: Expense(darkButton: _toggleTheme,),
    );
  }
}