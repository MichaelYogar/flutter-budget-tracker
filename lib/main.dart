import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'components/screens/home_screen.dart';
import 'core/services/service_locator.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  setUpServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Budget Tracker',
      home: HomeScreen(),
    );
  }
}
