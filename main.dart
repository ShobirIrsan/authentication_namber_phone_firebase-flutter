
import 'package:flutter/material.dart';
import 'package:flutter_crud_firecore/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_crud_firecore/services/services.dart';

void main() {
  runApp(MyHome());
}


class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthServices().handleAuth(),
    );
  }
}
