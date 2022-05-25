import 'package:barbar_manager/home_page.dart';
import 'package:flutter/material.dart';

main() => runApp(const Main());


class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomePage(),
    );
  }
}
