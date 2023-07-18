import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'Widgets/expense.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: 
  const Color.fromARGB(255, 96, 59, 181)
);
var kdarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 8, 99, 125)
);

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp
  //   ]
  // ).then((fn) => runApp,);
  //******** the above code is used to lock the device orientation where you UI never changes according to Device Orientation  **********/
  //************* and you have to move entire runApp code to the .then Function to work with this locked orientation **************/
  runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: kdarkColorScheme,

      cardTheme: const CardTheme().copyWith(
        color: kdarkColorScheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10)
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kdarkColorScheme.primaryContainer,
        )
        ),
    ),
    theme: ThemeData().copyWith(
      useMaterial3: true, 
      colorScheme: kColorScheme,
      // Use to Target appBar theme
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: kColorScheme.onPrimaryContainer,
        foregroundColor: kColorScheme.primaryContainer),
        //Use to Target Cards in app
      cardTheme: const CardTheme().copyWith(
        color: kColorScheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10)
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kColorScheme.primaryContainer,
        )
        ),
      textTheme: ThemeData().textTheme.copyWith(
        titleLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: kColorScheme.onSecondaryContainer,
          fontSize: 16
        )
      )
      ),
      

    debugShowCheckedModeBanner: false,
    home: const Expense(),
  )
  );
}


