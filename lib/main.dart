import 'package:flutter/material.dart';
import 'package:expenses_tracker/model/expenses.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(useMaterial3: true),
    home:  Expenses()),
  ); 
 
}
