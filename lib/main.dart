import 'package:cuba_pod/app/app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await SharedPreferences.getInstance();

  runApp(
    CubaPod(
      storage: storage,
    ),
  );
}
