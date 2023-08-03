import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

void testIt() {
  final cat = Cat();
  cat.run();
  cat.speed = 20;
  cat.run();
}

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    testIt();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
    );
  }
}

mixin CanRun on Animal {
  int get speed;

  void run() {
    'Running at the speed of $speed'.log();
  }
}

class Cat extends Animal with CanRun {
  @override
  int speed = 10;
}

abstract class Animal {
  const Animal();
}
