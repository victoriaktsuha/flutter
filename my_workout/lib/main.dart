import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/login_screen.dart';
import '../screens/exercise_management_screen.dart';
import '../screens/exercise_screen.dart';
import '../screens/workout_screen.dart';
import '../screens/home_screen.dart';
import '../screens/workout_management_screen.dart';

import '../providers/workout_providers.dart';
import '../providers/exercise_provider.dart';
import '../providers/auth_provider.dart';

import '../helpers/custom_page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, WorkoutProvider>(
          create: (_) => WorkoutProvider('',''), 
          update: (_, auth, workout) => WorkoutProvider(auth.user as String, auth.token as String),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ExerciseProvider>(
          create: (_) => ExerciseProvider(''), 
          update: (_, auth, exercise) => ExerciseProvider(auth.token as String),
        ),

      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Color.fromRGBO(29, 34, 37, 0.9),
          ),
          canvasColor: Colors.transparent,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: const Color.fromRGBO(0, 223, 100, 1),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          cardColor: const Color.fromRGBO(60, 70, 72, 0.9),
          scaffoldBackgroundColor: const Color.fromRGBO(29, 34, 37, 0.9),
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // useMaterial3: true,
          textTheme: 
            const TextTheme(
              //headline1
              displayLarge: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
              //headline4
              headlineMedium: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
              //bodyText1
              bodyLarge: TextStyle(
                color: Colors.white,
              ),
              //subtitle1
              titleMedium: TextStyle(
                color: Colors.white,
              ),
              //subtitle2
              titleSmall: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(151, 152, 152, 1),
              ),
            ),
            buttonTheme: ButtonThemeData(
              buttonColor: const Color.fromRGBO(0, 223, 100, 1),
              colorScheme: Theme.of(context).colorScheme.copyWith(primary: const Color.fromRGBO(0, 223, 100, 1),),
              // textTheme: ButtonTextTheme.primary,
            ),
            inputDecorationTheme: const InputDecorationTheme(
              fillColor: Color.fromRGBO(48, 56, 62, 0.9),
              filled: true,
              border: InputBorder.none,
              labelStyle: TextStyle(
                color: Color.fromRGBO(151, 152, 152, 1)
              ),
            ),
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Color.fromRGBO(0, 223, 100, 1),
              selectionHandleColor: Color.fromRGBO(0, 223, 100, 1),
            ),
            dialogBackgroundColor: const Color.fromRGBO(29, 34, 37, 1),
            dialogTheme: DialogTheme(
              titleTextStyle: TextStyle(
                color: Colors.white, 
                fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize
              ),
            ),
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CustomPageTransitionBuilder(),
                TargetPlatform.iOS: CustomPageTransitionBuilder(),
              }
            ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(0, 223, 100, 1),
            )
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: const Color.fromRGBO(0, 223, 100, 1),
              side: const BorderSide(width: 1, color: Colors.transparent),
            )
          )
        ),
        // home: const HomeScreen(),
        // initialRoute: '',
        home: Consumer<AuthProvider>(
          builder: (_, provider, widget){
            if (provider.token != null){
              return const HomeScreen();
            }
            return const LoginScreen();
          },
        ),
        // Routes
        routes: {
          HomeScreen.route: (_) => const HomeScreen(),
          WorkoutScreen.route: (_) => const WorkoutScreen(),
          WorkoutManagementScreen.route:(_) => const WorkoutManagementScreen(),
          ExerciseScreen.route: (_) => const ExerciseScreen(),
          ExerciseManagementScreen.route: (_) => const ExerciseManagementScreen(),
          LoginScreen.route: (_) => const LoginScreen(),
        }, 
      ),
    );
  }
}

