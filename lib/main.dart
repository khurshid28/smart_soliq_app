import 'package:flutter/material.dart';
import 'package:smart_soliq_app/app.dart';
import 'package:smart_soliq_app/core/init/full_init.dart';

void main() async {
  await FullInit();
  runApp(MyApp());
}
