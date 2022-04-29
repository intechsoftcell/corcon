import 'dart:async';

import 'package:corcon/screens/home_screen.dart';
import 'package:corcon/screens/navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<int, Color> colorSwatch = const {
      50: Color.fromRGBO(21, 34, 56, .1),
      100: Color.fromRGBO(21, 34, 56, .2),
      200: Color.fromRGBO(21, 34, 56, .3),
      300: Color.fromRGBO(21, 34, 56, .4),
      400: Color.fromRGBO(21, 34, 56, .5),
      500: Color.fromRGBO(21, 34, 56, .6),
      600: Color.fromRGBO(21, 34, 56, .7),
      700: Color.fromRGBO(21, 34, 56, .8),
      800: Color.fromRGBO(21, 34, 56, .9),
      900: Color.fromRGBO(21, 34, 56, 1),
    };
    ToastContext().init(context);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xff152238),
        primarySwatch: MaterialColor(0xff152238, colorSwatch),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateUser();
  }

  void navigateUser() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    if (_prefs.getBool("isLoggedIn") == true) {
      Timer(
          const Duration(seconds: 3),
          () => {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false)
              });
    } else {
      Timer(
          const Duration(seconds: 3),
          () => {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const NavigationScreen()),
                    (route) => false)
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Loading"),
            ),
          ],
        ),
      ),
    );
  }
}
