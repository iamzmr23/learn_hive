import 'package:flutter/material.dart';
import 'package:learn_hive/app.dart';
import 'package:learn_hive/src/service/db_hive.dart';

HiveUser auth = HiveUser();

void main() async {
  await HiveUser.init();
  runApp(const App());
}
